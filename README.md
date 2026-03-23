This project has been created as part of the 42 curriculum by tnolent

## Description
This project is a system administration project. The goal is to set up a small infrastructure composed of different services using Docker and Docker Compose, all running inside a Virtual Machine.
The infrastructure includes:

NGINX — the only entry point, listening on port 443 (TLS only)
WordPress — with PHP-FPM, connected to the database
MariaDB — the database backend for WordPress

I had to create three images, nginx, mariadb and wordpress, three container from the images and two volumes containing mariadb and wordpress data.

The goal of the project is to display a website that which uses a nginx server and a mariadb database.
All of that by running containners created from images themselves created by Dockerfiles made from scratch.

Each service runs in its own dedicated Docker container, built from a custom Dockerfile.

```
              ┌─────────────────────────────────────────┐
              │              Docker Network              │
              │                                          │
 HTTPS:443    │  ┌─────────┐    ┌───────────┐           │
─────────────►│  │  NGINX  │───►│ WordPress │           │
              │  └─────────┘    └─────┬─────┘           │
              │                       │                  │
              │                ┌──────▼──────┐           │
              │                │   MariaDB   │           │
              │                └──────┬──────┘           │
              └───────────────────────┼─────────────────┘
                                      │
                        ┌─────────────┴──────────────┐
                        │         Volumes             │
                        │  • wordpress_data           │
                        │  • mariadb_data             │
                        └─────────────────────────────┘
```
# Virtual Machines vs Docker
Docker containers share the host kernel and are isolated at the process level, making them much more lightweight and faster.
However, VMs offer stronger isolation.

# Secrets vs Environment Variables
In this project environment variables via a .env file are used for simplicity, keeping the .env out of version control.
Environment variables are simple key-value pairs passed to containers, but they can be exposed through docker inspect or logs.

# Docker Network vs Host Network
With host network, containers share the host's network namespace directly — no isolation. With a Docker network (bridge mode), each container gets its own IP on a virtual network, and containers communicate by service name (DNS resolution). This project uses a custom bridge network (inception) so containers can talk to each other securely without exposing internal ports to the outside world.

# Docker Volumes vs Bind Mounts
Bind mounts map a specific path on the host to a path in the container — useful for development and when the host path matters (as required by this project). Docker volumes are managed by Docker and stored in Docker's internal directory, offering better portability and performance on non-Linux systems. This project uses bind mounts to /home/tnolent/data/ so data persists on the host at a known location.

## Instruction 
To make this project work on your computer, I suggest you to create a .env file containing thoses variables :
```
/************.ENV FILE***********\
#DATABASE

SQL_DATABASE=wordpress
SQL_USER=login
SQL_PASSWORD=pasword
SQL_ROOT_PASSWORD=root_password

#ADMIN WP
DOMAIN_NAME=login.42.fr
WP_TITLE=inception
WP_ADMIN_USER=user
WP_ADMIN_PASSWORD=user_pasword
WP_ADMIN_EMAIL=user@exemple.fr

# USER WP
WP_USER2_LOGIN=user2
WP_USER2_EMAIL=user2@gmail.com
WP_USER2_PASSWORD=user2_pasword
/********************************\
```
Also, make sure to change the redirection localhost located in /etc/hosts/ next to 127.0.0.1 to login.42.fr

Then if you want, you can run this project on a VM but you're not obligated.

You must install docker and clone the repo and there you go !

### Useful commands
 
```bash
make          # Build and start all containers
make down     # Stop and remove containers
make clean    # Stop containers and remove images
make fclean   # Full cleanup including volumes
make re       # Rebuild everything from scratch
```

## Ressources

https://docker-curriculum.com/
https://www.youtube.com/watch?v=DQdB7wFEygo
https://www.geeksforgeeks.org/devops/docker-tutorial/

I used IA to help me setting my Virtual Machine with Vagrant. It was new to me and they were multiples problems.
It has told me how to debug things and make everything works perfectly

## 🐋 Services

### NGINX
Single entry point of the infrastructure. Handles **TLS (SSL)** termination and forwards requests to WordPress via **FastCGI (PHP-FPM)**.

### WordPress
PHP application running with **PHP-FPM**. Connects to MariaDB for data persistence and communicates with NGINX through the internal Docker network.

### MariaDB
Relational database. Data is stored in a dedicated volume to survive container restarts.

---

## 📦 Volumes
| `mariadb_data` | Database data |
| `wordpress_data` | WordPress files (themes, plugins, uploads…) |

Volumes are mounted on the host machine under `/home/login/data/`.

---

## 🔒 Security

- All communications use **HTTPS** via a self-signed TLS certificate.
- Passwords and sensitive information are injected through the `.env` file, **never hardcoded** in Dockerfiles.
- Containers communicate through an isolated **internal Docker network** ; only NGINX exposes a port to the outside.

---
