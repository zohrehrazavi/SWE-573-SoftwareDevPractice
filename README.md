# SWE573-SoftwareDevPractice

A Django-based knowledge-mapping platform created for SWE573. The system allows users to create nodes (representing people, topics, or any entities), enrich them with structured data (e.g., from Wikidata), and visualize their relationships on a graph. Each user can create boards, add multiple nodes, and manually or automatically enrich them with properties.

---

## Project Overview

This repository is used to manage the software development workflow including requirements gathering, planning, implementation, and research. It serves as a central space for organizing tasks, documentation, and code for the project.

---

## How to Run the Project

Follow these steps to run the project on a new computer:

### 1. Install Docker

Download and install Docker Desktop:  
👉 https://www.docker.com/products/docker-desktop

### 2. Clone the Repository

```bash
git clone https://github.com/zohrehrazavi/SWE-573-SoftwareDevPractice.git
cd SWE-573-SoftwareDevPractice
```

### 3. Build and Start the App

```bash
docker compose up --build
```

This will build the containers and start the web and database services. Once running, the application will be available at `http://localhost:8001`.

### 4. Run Migrations

In a new terminal tab, first create migration files (if needed), then apply them:

```bash
docker compose exec web python manage.py makemigrations
docker compose exec web python manage.py migrate
```

This ensures all database schema changes are detected and applied correctly.

### 5. Create Superuser (Optional)

```bash
docker compose exec web python manage.py createsuperuser
```

Use this to create an admin account to access Django's admin interface at `/admin`.

> **Note:** All backend commands should be run from the `web` service container.

---

## Repository Structure

- `backend/` – Django project files and apps (`nodes`, `user_auth`)
  - `nodes/` - Core functionality for boards, nodes, and edges
  - `user_auth/` - User authentication and security features
  - `tests/` - Comprehensive test suites
- `docker/` – Docker configurations
- `docker-compose.yml` – Docker service definitions
- `requirements.txt` – Python dependencies
- `README.md` – Project documentation

---

## Testing

The project includes comprehensive test coverage across all major components:

### Test Structure

- `backend/test/README.md` - Detailed test documentation and guidelines
- `backend/user_auth/tests/test_security.py` - Authentication and security tests
- `backend/nodes/tests/test_board_node.py` - Board and node management tests
- `backend/nodes/tests/test_api.py` - API endpoint tests

### Key Test Areas

1. **User Authentication & Security**

   - User registration and login
   - Security questions
   - Password reset functionality
   - Case-insensitive answer validation

2. **Board & Node Management**

   - Board creation with unique names
   - Node creation and validation
   - Edge management
   - Permission controls

3. **API Endpoints**

   - REST API functionality
   - Response validation
   - Authentication requirements

4. **Integration Features**
   - Wikidata integration
   - Property management
   - Edit request system
   - Contribution messages

### Running Tests

For local development (using SQLite):

```bash
# Run all tests with verbose output
python manage.py test backend.user_auth.tests backend.nodes.tests -v 2

# Run specific test suites
python manage.py test backend.user_auth.tests.test_security  # Security tests
python manage.py test backend.nodes.tests.test_board_node    # Board/Node tests
python manage.py test backend.nodes.tests.test_api           # API tests
```

With Docker (using PostgreSQL):

```bash
# Run all tests
docker compose exec web python manage.py test

# Run specific test suite with verbosity
docker compose exec web python manage.py test backend.user_auth.tests -v 2
```

### Test Coverage

The test suite includes:

- 32+ individual test cases
- Coverage across all major components
- Both unit and integration tests
- API endpoint validation
- Security feature verification

For detailed test documentation and guidelines, see [Test Documentation](backend/test/README.md).

---

## Features

- 🔍 **Graph Visualization**: Interactive network graph showing relationships between nodes
- 🕒 **Timeline View**: Users can toggle to a timeline mode that displays key events (reports, sightings, discoveries) in chronological order, helping map the case's progression more clearly

---
