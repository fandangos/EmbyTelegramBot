# Use the Arch Linux base image
FROM archlinux:latest

# Update and install Python and other necessary packages
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm python3 python-pip \
    && pacman -Scc --noconfirm

# Set working directory
WORKDIR /app

# Copy your Python script into the container
COPY ./telegram.py /app/
COPY ./requirements.txt /app

# Install any Python dependencies (optional)
#RUN pip install -r requirements.txt
RUN python -m venv /env
RUN /env/bin/pip install -r requirements.txt

# Declare envrironment variables
ENV TELEGRAM_TOKEN=
ENV TELEGRAM_CHAT=
ENV EMBY_URL=
ENV EMBY_API=

# Flask is mapped to port 5000
EXPOSE 5000

# Set entrypoint to run your Python script
CMD ["/env/bin/python", "telegram.py"]

