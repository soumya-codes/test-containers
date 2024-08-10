# Use the official Python image from the Docker Hub
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Install iproute2 and netcat
RUN apt-get update && apt-get install -y iproute2 netcat-openbsd

# Create a virtual environment
RUN python -m venv /venv

# Install the dice db CLI within the virtual environment
RUN /bin/bash -c "source /venv/bin/activate && pip install dicedb-cli"

# Copy the connect script, this would be used to connect to the dice-db instance.
COPY ./connect.sh /app/connect.sh
RUN chmod +x /app/connect.sh

# Set the default command to keep the container running
CMD ["bash", "-c", "while true; do sleep 3600; done"]
