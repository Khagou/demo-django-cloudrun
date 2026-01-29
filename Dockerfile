FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Cloud Run écoute sur 8080
ENV PORT=8080
CMD exec gunicorn app.wsgi:application --bind :$PORT --workers 2 --threads 8
