FROM python:3.8-alpine3.11

COPY ./configs/config.py /
COPY ./run.py /
COPY ./manage.py /


COPY ./configs/requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r /app/requirements.txt

# Install Supervisord
RUN apk add --no-cache supervisor
# Custom Supervisord config
COPY ./configs/supervisord.ini /etc/supervisor.d/supervisord.ini

# Used by the entrypoint to explicitly add installed Python packages
# and uWSGI Python packages to PYTHONPATH otherwise uWSGI can't import Flask
ENV ALPINEPYTHON python3.8

# Copy start.sh script that will check for a /app/prestart.sh script and run it before starting the app
COPY ./docker/start.sh /start.sh
RUN chmod +x /start.sh


# Add demo app
COPY ./app /app
#WORKDIR /app

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Supervisor, which in turn will start Nginx and uWSGI
CMD ["/start.sh"]