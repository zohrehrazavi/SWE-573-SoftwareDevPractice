# user_auth/utils.py
import requests

WIKIDATA_PROPERTIES = {
    #Identity & Demographics
    "P31": "instance_of",
    "P106": "occupation",
    "P21": "gender",
    "P27": "country_of_citizenship",
    "P569": "date_of_birth",
    "P570": "date_of_death",
    "P19": "place_of_birth",
    "P20": "place_of_death",
    "P551": "residence",
    "P734": "family_name",
    "P735": "given_name",
    "P172": "ethnic_group",
    "P4414": "eye_color",
    "P284": "hair_color",
    "P1884": "hair_type",

    #Case-Specific
    "P1476": "title",                # Title of report/testimony
    "P1433": "published_in",         # Source
    "P1559": "name_in_native_language", # For aliases/nicknames
    "P518": "applies_to_part",       # e.g., "scarf" in forensic report
    "P585": "point_in_time",         # Date of event, sighting, etc.
    
    # Investigative Properties (Manual Entry Only)
    "report_title": "report_title",
    "report_source": "report_source",
    "report_date": "report_date",
    "witness_name": "witness_name",
    "witness_account": "witness_account",
    "statement_platform": "statement_platform",
    "event_type": "event_type",
    "event_date": "event_date",
    "event_location": "event_location",
    "media_title": "media_title",
    "media_source": "media_source",
    "media_date": "media_date",
    "discovery_date": "discovery_date",
    "discovery_location": "discovery_location",
    "discovered_by": "discovered_by"
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
    # Basic Information
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
    
    # Case-Specific
    "title": "title",
    "published_in": "published in",
    "name_in_native_language": "name in native language",
    "applies_to_part": "applies to part",
    "point_in_time": "point in time",
    
    # Report Details
    "report_title": "report title",
    "report_source": "report source",
    "report_date": "report date",
    
    # Witness Information
    "witness_name": "witness name",
    "witness_account": "witness account",
    "statement_platform": "statement platform",
    
    # Event Information
    "event_type": "event type",
    "event_date": "event date",
    "event_location": "event location",
    
    # Media Evidence
    "media_title": "media title",
    "media_source": "media source",
    "media_date": "media date",
    
    # Discovery Information
    "discovery_date": "discovery date",
    "discovery_location": "discovery location",
    "discovered_by": "discovered by"
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
