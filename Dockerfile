FROM python:3.9-slim

# Set working directory inside container
WORKDIR /app

# Copy project files into container
COPY . /app

# Expose port
EXPOSE 8080

# Command to run the app
CMD ["python3", "-m", "http.server", "8080"]

