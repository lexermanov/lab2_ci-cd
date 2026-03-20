FROM python:3.9-slim

# Рабочая директория
WORKDIR /app

# Установка системных пакетов
RUN apt-get update && apt-get install -y curl vim && rm -rf /var/lib/apt/lists/*

# Копируем зависимости
COPY requirements.txt .

# Устанавливаем Python пакеты
RUN pip install --no-cache-dir -r requirements.txt

# Копируем приложение
COPY app.py .

# Создаём пользователя
RUN useradd -m -u 1000 appuser

# Переключаемся на него
USER appuser

# Открываем порт
EXPOSE 5000

# Переменная окружения
ENV FLASK_ENV=production

# Запуск приложения
CMD ["python", "app.py"]