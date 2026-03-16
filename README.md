This project consist of Mastering Docker

I had to create three images, nginx, mariadb and wordpress, three container from the images and two volumes containing mariadb and wordpress data.

The goal of the project is to display a website that which uses a nginx server and a mariadb database.
All of that by running containners created from images themselves created by Dockerfiles made from scratch.

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
