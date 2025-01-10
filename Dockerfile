FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy your Flask app and requirements.txt into the container
COPY . /app

# Install the dependencies
RUN pip install -r requirements.txt

# Expose the port the app will run on
EXPOSE 5000

# Run Flask app
CMD ["python", "app.py"]
