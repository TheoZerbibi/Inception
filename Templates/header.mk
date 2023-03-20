# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    header.mk                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thzeribi <thzeribi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/07/26 01:52:22 by thzeribi          #+#    #+#              #
#    Updated: 2023/03/20 11:21:51 by thzeribi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RULE := $(filter all re clean fclean norm header asan,$(MAKECMDGOALS))

AUTHOR	:= thzeribi
DATE	:= $(shell date +%F)
SPACE	:= -51

define print_header
	printf "%b" "$(INFO_COLOR)";
	echo "=============================================================================================="
	echo "|| $(OK_COLOR) _______  _______  _        _______  $(OBJ_COLOR)    _______ _________ _______  _______  _$(INFO_COLOR)           ||";
	echo "|| $(OK_COLOR)(       )(  ___  )| \    /\(  ____ \ $(OBJ_COLOR)   (  ___  )\__   __/(  ____ )(  ___  )( (    /|$(INFO_COLOR)    ||";
	echo "|| $(OK_COLOR)| () () || (   ) ||  \  / /| (    \/ $(OBJ_COLOR)   | (   ) |   ) (   | (    )|| (   ) ||  \  ( |$(INFO_COLOR)    ||";
	echo "|| $(OK_COLOR)| || || || (___) ||  (_/ / | (__  ___$(OBJ_COLOR)__ | (___) |   | |   | (____)|| |   | ||   \ | |$(INFO_COLOR)    ||";
	echo "|| $(OK_COLOR)| |(_)| ||  ___  ||   _ (  |  __)(___$(OBJ_COLOR)__)|  ___  |   | |   |     __)| |   | || (\ \) |$(INFO_COLOR)    ||";
	echo "|| $(OK_COLOR)| |   | || (   ) ||  ( \ \ | (       $(OBJ_COLOR)   | (   ) |   | |   | (\ (   | |   | || | \   |$(INFO_COLOR)    ||";
	echo "|| $(OK_COLOR)| )   ( || )   ( ||  /  \ \| (____/\ $(OBJ_COLOR)   | )   ( |   | |   | ) \ \__| (___) || )  \  |$(INFO_COLOR)    ||";
	echo "|| $(OK_COLOR)|/     \||/     \||_/    \/(_______/ $(OBJ_COLOR)   |/     \|   )_(   |/   \__/(_______)|/    )_).V4$(INFO_COLOR) ||";
	echo "||                                                                                          ||";
	printf "\033[m$(INFO_COLOR)|| $(OK_COLOR)\t\t\t\tName:	$(OBJ_COLOR)%$(SPACE)s %b\033[m" "$(PROJECT_NAME)" "$(INFO_COLOR)||\n"
	printf "$(INFO_COLOR)|| $(OK_COLOR)\t\t\t\tAuthor:	$(OBJ_COLOR)%$(SPACE)s %b\033[m" "$(AUTHOR)" "$(INFO_COLOR)||\n"
	printf "$(INFO_COLOR)|| $(OK_COLOR)\t\t\t\tDate: 	$(OBJ_COLOR)%$(SPACE)s %b\033[m" "$(DATE)" "$(INFO_COLOR)||\n"
	printf "$(INFO_COLOR)|| $(OK_COLOR)\t\t\t\tCC: 	$(OBJ_COLOR)%-$(SPACE)s %b\033[m" "$(CC)" "$(INFO_COLOR)||\n"
	printf "$(INFO_COLOR)|| $(OK_COLOR)\t\t\t\tFlags: 	$(OBJ_COLOR)%$(SPACE).48s %b\033[m" "$(CFLAGS)" "$(INFO_COLOR)||\n"
	[ "${RULE}" ] && printf "$(INFO_COLOR)|| $(OK_COLOR)\t\t\t\tRule:$(OBJ_COLOR)   %-$(SPACE)s %b\033[m" "$(RULE)" "$(INFO_COLOR)||\n"; \
	echo "$(INFO_COLOR)||                                                                                          ||";
	echo "=============================================================================================="
endef

header:
	clear
	$(call print_header)