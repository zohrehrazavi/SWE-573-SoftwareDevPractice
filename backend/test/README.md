# 🧪 Test Suite Documentation

This document summarizes the test coverage for the Django project.

## ✅ Test Coverage Overview

| Module / Component     | Test Type                       | Status     |
| ---------------------- | ------------------------------- | ---------- |
| `nodes/models.py`      | Model creation, relationships   | ✅ Covered |
| `nodes/views.py` (API) | Node list & create endpoints    | ✅ Covered |
| `user_auth/forms.py`   | All forms validation            | ✅ Covered |
| `user_auth/views.py`   | Auth-protected views            | ✅ Covered |
| Board Management       | Creation, permissions           | ✅ Covered |
| Edge Management        | Creation, labeling              | ✅ Covered |
| Wikidata Integration   | Search, property fetching       | ✅ Covered |
| Property Management    | Manual & auto property handling | ✅ Covered |
| Security Questions     | Registration, password reset    | ✅ Covered |
| Edit Request System    | Request lifecycle, permissions  | ✅ Covered |
| Contribution Messages  | CRUD operations, permissions    | ✅ Covered |

## 📁 Test File Locations

- `backend/user_auth/tests/test_security.py`: User registration and login tests
- `backend/user_auth/tests/test_security.py`: Security questions and password reset tests
- `backend/nodes/tests/test_board_node.py`: Board, node, and edge management tests
- `backend/nodes/tests/test_api.py`: API endpoint tests for nodes

## 🧪 How to Run Tests

From the project root directory:

```bash
# Run all tests with verbose output
python manage.py test backend.user_auth.tests backend.nodes.tests -v 2

# Run specific test file
python manage.py test backend.user_auth.tests.test_security
python manage.py test backend.nodes.tests.test_board_node
python manage.py test backend.nodes.tests.test_api
```

## 📊 Current Test Coverage

Total number of tests: 32

1. User Authentication (2 tests)

   - User registration with validation
   - User login with various scenarios

2. Security Questions (6 tests)

   - Security question creation during registration
   - Registration field validation
   - Password reset flow with security answers
   - Password reset validation
   - Password reset confirmation
   - Case-insensitive answer validation

3. Board and Node Management (4 tests)

   - Board creation with unique name validation
   - Node creation and validation
   - Edge creation and management
   - Board editor permissions

4. API Endpoints (2 tests)
   - Node list retrieval
   - Node creation via API

## 🔍 Test Categories

1. **Unit Tests**

   - Model validations (Board, Node, Edge)
   - Form validations (User registration, Board creation)
   - Security question handling

2. **Integration Tests**

   - Board creation with permissions
   - Edge creation between nodes
   - Password reset flow

3. **API Tests**
   - REST endpoints for nodes
   - Authentication requirements
   - Response format validation

## 📝 Test Writing Guidelines

1. **Naming Convention**

   - Test files should be named `test_*.py`
   - Test classes should end with `Tests` or `TestCase`
   - Test methods should start with `test_`

2. **Test Organization**

   - Use descriptive test method names
   - Group related tests in the same class
   - Use appropriate test categories

3. **Assertions**
   - Use appropriate assertion methods
   - Check both positive and negative cases
   - Validate all relevant aspects of the response
