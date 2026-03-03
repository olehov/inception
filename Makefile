NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml
DATA_PATH = /home/$(USER)/data
WP_DATA = $(DATA_PATH)/wordpress
DB_DATA = $(DATA_PATH)/mariadb

all: prepare
	$(COMPOSE) up --build

build: prepare
	$(COMPOSE) build

up: prepare
	$(COMPOSE) up

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean:
	$(COMPOSE) down -v --rmi all
	sudo rm -rf $(WP_DATA)
	sudo rm -rf $(DB_DATA)

prepare:
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)

re: fclean all

.PHONY: all build up down clean fclean re prepare
