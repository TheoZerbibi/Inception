# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thzeribi <thzeribi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/19 12:13:48 by thzeribi          #+#    #+#              #
#    Updated: 2023/04/08 12:35:08 by thzeribi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#                                   CONFIG                                     #
################################################################################

ifndef VERBOSE
	MAKEFLAGS += --no-print-directory --silent
endif

PROJECT_NAME		:=	Inception

################################################################################
#                                  SOURCES                                     #
################################################################################
SOURCES_FOLDER	:=	./srcs/
COMPOSE			:=	docker compose --project-directory ${SOURCES_FOLDER}
DATA			:=	${HOME}/data
VOLUMES			:=	${addprefix ${DATA}/,	\
						wordpress			\
						mariadb				\
						portfolio			\
						info				\
						grafana				\
						prometheus			\
					}

################################################################################
#                                 COLORS                                       #
################################################################################

NO_COLOR 		:=	\033[38;5;15m
OK_COLOR		:=	\033[38;5;2m
ERROR_COLOR		:=	\033[38;5;1m
WARN_COLOR		:=	\033[38;5;3m
SILENT_COLOR	:=	\033[38;5;245m
INFO_COLOR		:=	\033[38;5;140m
OBJ_COLOR		:=	\033[0;36m

################################################################################
#                                 RULES                                        #
################################################################################

.PHONY: all
all: header up

.PHONY: up
up: create_dir build create
	${COMPOSE} up -d

.PHONY: stop down build create
stop down build create:
	${COMPOSE} $@

.PHONY: exec
exec:
	${COMPOSE} exec -it $(word 2,${MAKECMDGOALS}) sh

.PHONY: ps
ps:
	${COMPOSE} $@ -a

.PHONY: clean
clean:
	${COMPOSE} down --rmi all

.PHONY: fclean
fclean:
	${COMPOSE} down --rmi all --volumes
	docker system prune -af
	sudo rm -rf ${VOLUMES}

.PHONE: create_dir
create_dir:
	mkdir -p ${VOLUMES}	

.PHONY: re
re: fclean all

-include ./Templates/header.mk