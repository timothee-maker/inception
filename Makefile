COMPOSE = docker compose -f ./srcs/docker-compose.yml
VOLUME = /home/tnolent/data/wp_files /home/tnolent/data/mariadb_data
all: up

up:
	mkdir -p $(VOLUME)
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

build:
	$(COMPOSE) build --no-cache

rebuild: down build up

status:
	docker ps

fclean:
	$(COMPOSE) down -v
	rm -rf $(VOLUME)
	docker system prune -af --volumes

re: fclean all

.PHONY: all up down clean fclean re