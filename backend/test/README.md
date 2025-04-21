# 🧪 Test Suite Documentation

This document summarizes the test coverage for the Django project.

## ✅ Test Coverage Overview

| Module / Component        | Test Type                       | Status       |
|---------------------------|----------------------------------|--------------|
| `nodes/models.py`         | Model creation, relationships    | ✅ Covered   |
| `nodes/views.py` (API)    | Node list & create endpoints     | ✅ Covered   |
| `user_auth/forms.py`      | All forms validation             | ✅ Covered   |
| `user_auth/views.py`      | Auth-protected views, node/board forms | ✅ Covered |
| Wikidata Enrichment       | View test with mocked enrichment | ✅ Covered   |
| Manual Property Addition  | POST-based view test             | ✅ Covered   |

## 📁 Test File Locations

- `backend/nodes/tests.py`: Model tests and API endpoint tests for nodes.
- `backend/user_auth/tests.py`: View access, form validation, and logic tests for Wikidata enrichment and manual property handling.

## 🧪 How to Run Tests

From the project root directory:

```bash
python backend/manage.py test
