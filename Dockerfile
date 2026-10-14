# Use a slim, official Python production environment
FROM python:3.11-slim

WORKDIR /app

# Install system utilities needed to compile vector search tools if required
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Pre-copy package requirements to speed up rebuild caches
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Bring the rest of the application ecosystem into the frame
COPY . .

# Expose standard routing port
EXPOSE 8000

# Execute server initialization framework
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
