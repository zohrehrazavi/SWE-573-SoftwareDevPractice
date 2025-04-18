# user_auth/utils.py
import requests

WIKIDATA_PROPERTIES = {
    #Identity & Demographics
    "P31": "instance of",
    "P106": "occupation",
    "P21": "gender",
    "P27": "country of citizenship",
    "P569": "date of birth",
    "P570": "date of death",
    "P19": "place of birth",
    "P20": "place of death",
    "P551": "residence",
    "P734": "family name",
    "P735": "given name",
    "P172": "ethnic group",
    "P4414": "eye color",
    "P284": "hair color",
    "P1884": "hair type",

    #Case-Specific
    "P1476": "title",                # Title of report/testimony
    "P1433": "published in",         # Source
    "P1559": "name in native language", # For aliases/nicknames
    "P518": "applies to part",       # e.g., "scarf" in forensic report
    "P585": "point in time"          # Date of event, sighting, etc.
}


def get_wikidata_id_from_label(label):
    search_url = "https://www.wikidata.org/w/api.php"
    params = {
        "action": "wbsearchentities",
        "format": "json",
        "language": "en",
        "search": label,
    }
    response = requests.get(search_url, params=params)
    results = response.json().get("search", [])
    if results:
        return results[0].get("id")
    return None

def fetch_wikidata_properties_by_name(name):
    wikidata_id = get_wikidata_id_from_label(name)
    if not wikidata_id:
        return None, {}

    entity_url = f"https://www.wikidata.org/wiki/Special:EntityData/{wikidata_id}.json"
    response = requests.get(entity_url)
    if response.status_code != 200:
        return wikidata_id, {}

    data = response.json()
    entity = data.get('entities', {}).get(wikidata_id, {})
    claims = entity.get('claims', {})

    properties = {}
    for prop_id, label in WIKIDATA_PROPERTIES.items():
        if prop_id in claims:
            mainsnak = claims[prop_id][0]['mainsnak']
            if mainsnak['snaktype'] == 'value':
                value = mainsnak['datavalue']['value']
                if isinstance(value, dict) and 'id' in value:
                    qid = value['id']
                    readable_label = get_label_from_wikidata_id(qid)
                    properties[label] = readable_label
                else:
                    properties[label] = value

    return wikidata_id, properties

def get_label_from_wikidata_id(qid):
    url = f"https://www.wikidata.org/wiki/Special:EntityData/{qid}.json"
    response = requests.get(url)
    if response.status_code != 200:
        return qid  # fallback to ID if not found
    data = response.json()
    entity = data.get("entities", {}).get(qid, {})
    labels = entity.get("labels", {})
    return labels.get("en", {}).get("value", qid)

# Maps form field names to human-readable labels
FORM_LABEL_TO_PROPERTY_LABEL = {
    "instance_of": "instance of",
    "occupation": "occupation",
    "gender": "gender",
    "country_of_citizenship": "country of citizenship",
    "date_of_birth": "date of birth",
    "date_of_death": "date of death",
    "place_of_birth": "place of birth",
    "place_of_death": "place of death",
    "residence": "residence",
    "family_name": "family name",
    "given_name": "given name",
    "ethnic_group": "ethnic group",
    "eye_color": "eye color",
    "hair_color": "hair color",
    "hair_type": "hair type",
    "title": "title",
    "published_in": "published in",
    "name_in_native_language": "name in native language",
    "applies_to_part": "applies to part",
    "point_in_time": "point in time",
}

# Converts stored node properties (human-readable) into form-compatible keys
def map_properties_to_form_initial(node_properties):
    initial_data = {}
    for form_field, label in FORM_LABEL_TO_PROPERTY_LABEL.items():
        if label in node_properties:
            val = node_properties[label]
            # Handle if it's a nested dict like in "date of birth"
            initial_data[form_field] = str(val) if isinstance(val, dict) else val
    return initial_data
