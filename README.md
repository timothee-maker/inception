This project consist of Mastering Docker

I had to create three images, nginx, mariadb and wordpress, three container from the images and two volumes containing mariadb and wordpress data.

The goal of the project is to display a website that which uses a nginx server and a mariadb database.
All of that by running containners created from images themselves created by Dockerfiles.

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
