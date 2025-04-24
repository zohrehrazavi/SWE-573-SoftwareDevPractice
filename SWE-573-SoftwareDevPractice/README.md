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

This will build the containers and start the web and database services.

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

Use this to create an admin account to access Django's admin panel.

> **Note:** All backend commands should be run from the `web` service container.

---

## Development URLs

```
Main App:       http://localhost:8001/
Admin Panel:    http://localhost:8001/admin/
Login Page:     http://localhost:8001/auth/login/
```

---

## Repository Structure

- `backend/` – Django project files and apps (`nodes`, `user_auth`)
- `docker/` – Docker configurations
- `docker-compose.yml` – Docker service definitions
- `requirements.txt` – Python dependencies
- `README.md` – Project documentation
