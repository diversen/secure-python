# Use a lightweight Python image
FROM python:3.11-slim

# Create a non-root user for security
RUN useradd -m restricted_user && \
    mkdir /sandbox && \
    chown restricted_user:restricted_user /sandbox

# Switch to non-root user
USER restricted_user

# Set working directory inside the container
WORKDIR /sandbox

# Install necessary Python libraries
RUN pip install --no-cache-dir numpy pandas matplotlib

# Default command: Run Python (script provided at runtime)
CMD ["python", "/sandbox/script.py"]