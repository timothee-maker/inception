COMPOSE = docker compose -f ./srcs/docker-compose.yml
all: up

up:
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
	docker system prune -af --volumes

re: fclean all

.PHONY: all up down clean fclean re