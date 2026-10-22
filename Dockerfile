FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Сначала зависимости — чтобы кэш слоёв работал лучше
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Потом код
COPY app.py .

EXPOSE 5000

# В проде запускаем через gunicorn, а не dev-сервер Flask
CMD ["gunicorn", "-b", "0.0.0.0:5000", "--workers", "2", "app:app"]
