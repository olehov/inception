NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml

all:
	$(COMPOSE) up --build

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean:
	$(COMPOSE) down -v --rmi all
	sudo rm -rf /home/$(USER)/data/wordpress/*
	sudo rm -rf /home/$(USER)/data/mariadb/*

re: fclean all

.PHONY: all build up down clean fclean re
