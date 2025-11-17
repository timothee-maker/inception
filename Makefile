COMPOSE = docker compose -f ./srcs/docker-compose.yml
#VOLUME = /home/tnolent/data /home/tnolent/data/wp_files /home/tnolent/data/mariadb_data
VOLUME = $(HOME)/data $(HOME)/data/wp_files $(HOME)/data/mariadb_data
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

clean :
	$(COMPOSE) down -v --rmi all --volumes

rebuild: clean up

restart: stop start

fclean: clean
#	sudo rm -rf $(VOLUME)
#	docker run --rm -v $(HOME)/data:/data alpine sh -c "rm -rf /data/*"
	docker system prune -af --volumes

re: fclean all

.PHONY: all up down clean fclean re
