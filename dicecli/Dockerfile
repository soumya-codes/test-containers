# Use the official Python image from the Docker Hub
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Create a virtual environment inside the container
RUN python -m venv /venv

# Install the dice db CLI within the virtual environment
RUN /bin/bash -c "source /venv/bin/activate && pip install dicedb-cli"

# Copy a simple test script to verify installation (optional)
COPY ./test_script.sh /app/test_script.sh
RUN chmod +x /app/test_script.sh
RUN /app/test_script.sh

# Set the default command to activate the virtual environment and start a bash shell
#CMD ["/bin/bash", "-c", "source /venv/bin/activate && bash"]
