# Use a minimal Python image based on Alpine Linux
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /app

# Install dependencies (you may need to install some build dependencies first)
COPY requirements.txt .
RUN apk add --no-cache gcc musl-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del gcc musl-dev  # Remove build dependencies after installation

# Copy the application code to the container
COPY . .

# Expose port 5000 to allow external access
EXPOSE 5000

# Command to start the application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
