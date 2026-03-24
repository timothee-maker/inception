## Set up the environment from scratch (prerequisites, configuration files, secrets).
Install on your host : VirtualBox or any other machine like UTM, etc.
Install Vagrant or any other linux distribution like Debian, Ubuntu, etc

To make this project work on your computer, you must create a .env file containing thoses variables :
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
Those variables are gonna be secret and not only accessible by you and your team. They mustn't be harcode in Dockerfiles or script

Also, make sure to change the redirection localhost located in /etc/hosts/ next to 127.0.0.1 to login.42.fr

Then if you want, you can run this project on a VM but you're not obligated.

You must install docker and clone the repo and there you go !


## Build and launch the project using the Makefile and Docker Compose.
```bash
make          # Build and start all containers
make down     # Stop and remove containers
make clean    # Stop containers and remove images
make fclean   # Full cleanup including volumes
make re       # Rebuild everything from scratch
```

## Use relevant commands to manage the containers and volumes.

```bash
# To see all the containers states and their image
docker ps

# To see logs of a service
docker logs c_nginx
docker logs c_wordpress
docker logs c_mariadb

# Enter in a container
docker exec -it c_mariadb bash
docker exec -it c_wordpress bash

# Verify that mariadb respond
docker exec -it c_mariadb mysql -u root -p

# Check mariadb data base
docker exec -it c_mariadb mysql -u $SQL_USER -p$SQL_PASSWORD $SQL_DATABASE
SHOW DATABASES;

# Vérifier les utilisateurs
SELECT User, Host FROM mysql.user;

# Se connecter à la base WordPress
USE wordpress;
SHOW TABLES;


# Verify that Wordpress respond
curl -k https://tnolent.42.fr

# Check volumes 
docker volume ls
```

## Identify where the project data is stored and how it persists.

Data are stored and located in /home/login/data/wp_files for wordpress files and /home/login/data/mariadb_data for mariadb data.

It persists because these directories are mounted as bind mounts in the containers in the docker-compose file

# docker-compose.yml
``` bash
volumes:
  wp_files:
    driver: local
    driver_opts:
      device: /home/tnolent/data/wp_files   # ← dossier réel sur la VM

  mariadb_data:
    driver: local
    driver_opts:
      device: /home/tnolent/data/mariadb_data
```

When you run `docker compose down`, the containers are deleted, but `/home/tnolent/data/` remains intact on the VM.
The next time you run `make`, Docker remounts the same directories because the data is still there.
Only `make fclean` deletes the volumes and, consequently, the data.

