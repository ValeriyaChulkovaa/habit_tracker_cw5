# Базовый образ
FROM python:3.12-slim

# Рабочая директория
WORKDIR /app

# Установка системных зависимостей
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        python3-dev \
        libpq-dev && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Копирование и установка Python-зависимостей
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Копируем проект
COPY . .

# Скрипт будет запускаться отсюда
EXPOSE 8000

# Команда по умолчанию (заменится в docker-compose)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]