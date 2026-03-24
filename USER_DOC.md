## Understand what services are provided by the stack

NGINX — The only entry point, receive HTTPS requests and forward them to wordpresss via FastCGI
WordPress + PHP-FPM — Give dynamic pages and communicate with the database
MariaDB — Store all data

## Start and stop the project
```bash
make          # Build and start all containers
make down     # Stop and remove containers
make clean    # Stop containers and remove images
make fclean   # Full cleanup including volumes
make re       # Rebuild everything from scratch
```

## Access the website and the administration panel
### From your host machine
Vagrant exposes the VM on a private network at `192.168.56.10`.
Open your browser and navigate to:
```
https://192.168.56.10
```
Or, if you have added the domain to your `/etc/hosts`:
```
https://tnolent.42.fr
```
The WordPress admin panel is available at:
```
https://tnolent.42.fr/wp-admin
```

Your browser will warn you about the self-signed TLS certificate — this is expected. Click "Advanced" and then "Proceed anyway".

### From inside the VM
The VM has no graphical interface, but you can verify the site is running with:
```bash
curl -k https://tnolent.42.fr
# or
curl -k https://192.168.56.10
```
A successful response will return the HTML of the WordPress homepage.

## Locate and manage credentials
Envirement variable are strore in the .env file in srcs.
.env file must be ignore by the .gitignore file
Passwords and credentials information mustn't be hardcode in Dockerfiles or scripts.

## Check that the services are running correctly

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