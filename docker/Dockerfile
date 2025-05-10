# --- Frontend Test Stage ---
FROM node:18 AS frontend-test
WORKDIR /frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm test

# --- Backend Stage ---
FROM python:3.11

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /app/

RUN python manage.py collectstatic --noinput

# This will only run if the previous stages (including frontend-test) succeed
CMD ["sh", "-c", "python manage.py migrate && gunicorn project.wsgi:application --bind 0.0.0.0:8000"]
