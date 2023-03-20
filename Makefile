# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thzeribi <thzeribi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/19 12:13:48 by thzeribi          #+#    #+#              #
#    Updated: 2023/03/20 11:41:49 by thzeribi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#                                   CONFIG                                     #
################################################################################

ifndef VERBOSE
	MAKEFLAGS += --no-print-directory --silent
endif

NAME				:=	cub3D
PROJECT_NAME		:=	Inception

################################################################################
#                                  SOURCES                                     #
################################################################################
SOURCES_FOLDER	:=	./srcs/
COMPOSE			:=	docker compose --project-directory ${SOURCES_FOLDER}
DATA_DIR		:=	${HOME}/data

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
up:
	${COMPOSE} up -d

.PHONY: stop down
stop down:
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
	rm -rf ${DATA_DIR}/*

.PHONY: re
re: clean all

-include ./Templates/header.mk