# uwsgi-nginx-flask

**Docker** image with **uWSGI** and **Nginx** for **Flask** web applications in **Python 3.8** running in a single container. Using Alpine Linux.

## General Instructions

Uses the default Flask development server.

1. Just do a normal "git clone" as usual.
1. Update the environment variables in the *docker-compose.yml*  and */configs/config.py* files.
1. Build the images and run the containers:
```sh
docker-compose up -d --build
```

