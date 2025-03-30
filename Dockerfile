# Use a minimal Python image
FROM python:3.11-slim

# Create a restricted user (no root access)
RUN useradd -m restricted_user && mkdir /sandbox && chown restricted_user:restricted_user /sandbox

# Switch to the non-root user
USER restricted_user

# Set working directory inside the container
WORKDIR /sandbox

# Install only essential Python libraries
RUN pip install --no-cache-dir numpy pandas matplotlib requests matplotlib

# Entry point: Python will execute the script passed as an argument
ENTRYPOINT ["python"]
