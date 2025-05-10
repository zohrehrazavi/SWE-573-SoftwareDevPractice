# Test README

This directory contains the test files for the user authentication module. The tests are organized as follows:

- `test_auth.py`: Tests for authentication-related functionality.
- `test_properties.py`: Tests for user properties and related features.
- `test_security.py`: Tests for security-related functionality.

Note: The `tests.py` file has been removed to avoid conflicts with Django's test discovery. All tests are now located in the `tests/` directory.

## Overview

This test suite contains comprehensive tests for the property handling functionality in the Connect the Dots application. The tests cover both manual property management and Wikidata integration.

## Test Files

### `test_properties.py`

Tests for property handling functionality including:

- Manual property addition
- Wikidata property fetching
- Property approval workflow
- Property display
- Property organization in sections

## Running Tests

### Using SQLite (Local Development)

```bash
DJANGO_SETTINGS_MODULE=project.test_settings python manage.py test backend.user_auth.tests
```

### Using PostgreSQL (Docker Environment)

```bash
python manage.py test backend.user_auth.tests
```

## Test Cases

### PropertyHandlingTestCase

1. **Manual Property Addition** (`test_manual_property_addition`)

   - Tests adding properties manually through forms
   - Verifies correct property name formatting (with underscores)
   - Checks proper value storage and redirects
   - **Covers all new investigative fields (report, witness, event, media, discovery)**

2. **Wikidata Property Fetching** (`test_wikidata_property_fetching`)

   - Tests the Wikidata API integration
   - Verifies proper handling of Wikidata responses
   - Checks redirect flow to property review

3. **Property Approval** (`test_property_approval`)

   - Tests the approval workflow for Wikidata properties
   - Verifies session handling for suggested properties
   - Checks proper storage of approved properties
   - **Covers all new investigative fields (report, witness, event, media, discovery)**

4. **Property Display** (`test_property_display`)

   - Tests the rendering of properties in node detail view
   - Verifies all property types are displayed correctly
   - Checks presence of property values in the response

5. **Property Organization** (`test_property_organization`)

   - Tests the organization of properties into sections
   - Verifies correct section headers
   - Checks property placement within appropriate sections

6. **Add Property Form Rendering** (`test_add_property_form_renders_all_fields`)

   - Tests that the Add/Edit Property form renders all new investigative fields
   - Loads the add property page and checks for all new field labels in the HTML

7. **Edit Node Name and Description** (`test_edit_node_name_and_description`)
   - Tests editing a node's name and description via the edit_node view
   - Ensures changes are saved and visible on the node detail page

## Test Data

The test suite uses a sample node ("brad pitt") and exercises all property types, including:

- Basic Information (instance_of, occupation)
- Personal Details (gender, country_of_citizenship, family_name, given_name, name_in_native_language)
- Biographical Data (date_of_birth, date_of_death, place_of_birth, place_of_death, residence, ethnic_group)
- Physical Characteristics (eye_color, hair_color, hair_type)
- Additional Information (title, published_in, applies_to_part, point_in_time)
- Report Details (report_title, report_source, report_date)
- Witness Information (witness_name, witness_account, statement_platform)
- Event Information (event_type, event_date, event_location)
- Media Evidence (media_title, media_source, media_date)
- Discovery Information (discovery_date, discovery_location, discovered_by)

## Adding New Tests

When adding new tests:

1. Follow the existing test structure
2. Use the provided test settings (SQLite for local testing)
3. Add test documentation to this README
4. Ensure all tests are independent and can run in isolation
