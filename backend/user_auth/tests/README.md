# Test Suite Documentation

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

2. **Wikidata Property Fetching** (`test_wikidata_property_fetching`)

   - Tests the Wikidata API integration
   - Verifies proper handling of Wikidata responses
   - Checks redirect flow to property review

3. **Property Approval** (`test_property_approval`)

   - Tests the approval workflow for Wikidata properties
   - Verifies session handling for suggested properties
   - Checks proper storage of approved properties

4. **Property Display** (`test_property_display`)

   - Tests the rendering of properties in node detail view
   - Verifies all property types are displayed correctly
   - Checks presence of property values in the response

5. **Property Organization** (`test_property_organization`)
   - Tests the organization of properties into sections
   - Verifies correct section headers
   - Checks property placement within appropriate sections

## Test Data

The test suite uses a sample node ("brad pitt") with various properties to verify functionality:

- Basic Information (instance_of, occupation)
- Personal Details (gender, country_of_citizenship)
- Physical Characteristics (eye_color, hair_type)

## Adding New Tests

When adding new tests:

1. Follow the existing test structure
2. Use the provided test settings (SQLite for local testing)
3. Add test documentation to this README
4. Ensure all tests are independent and can run in isolation
