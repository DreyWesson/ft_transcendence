# NAME = ft_transcendence

# # COMPILER
# CC = c++
# CFLAGS = -Werror -Wall -Wextra -std=c++98 #-fsanitize=address
# RM = rm -rf

# # DIRECTORIES
# SRC =	$(wildcard *.cpp **/*.cpp **/*/*.cpp **/*/*/*.cpp)
# OBJ_DIR = obj
# SRC_DIR = src
# INC_DIR = inc
# OBJS = $(SRC:%.cpp=$(OBJ_DIR)/%.o)

# # COLOURS
# NONE='\033[0m'
# GREEN='\033[32m'
# GRAY='\033[2;37m'
# CURSIVE='\033[3m'
# WARNING='\033[33m'

# all: $(NAME)

# $(NAME): $(OBJS)
# 	@$(CC) $(OBJS) -o $@ $(CFLAGS)
# 	@echo $(GREEN)"- Compiled -"$(NONE)

# $(OBJ_DIR)/%.o: %.cpp 
# 	@echo $(CURSIVE)$(GRAY) "     - Building $<" $(NONE)
# 	@mkdir -p $(dir $@)
# 	@$(CC) $(CFLAGS) -c $< -o $@

# clean:
# 	@$(RM) $(OBJS) $(OBJ_DIR)
# 	@echo $(CURSIVE)$(GRAY) "     - Object files removed" $(NONE)

# fclean: clean
# 	@rm -f $(NAME)
# 	@echo $(CURSIVE)$(GRAY) "     - $(NAME) removed" $(NONE)

# re: fclean all

# .PHONY: all clean fclean re
NAME = ft_transcendence

# COMPILER
CC = c++
CFLAGS = -Werror -Wall -Wextra -std=c++98 #-fsanitize=address
RM = rm -rf

# DIRECTORIES
SRC = $(wildcard *.cpp **/*.cpp **/*/*.cpp **/*/*/*.cpp)
OBJ_DIR = obj
SRC_DIR = src
INC_DIR = inc
OBJS = $(SRC:%.cpp=$(OBJ_DIR)/%.o)

# COLOURS
NONE='\033[0m'
GREEN='\033[32m'
GRAY='\033[2;37m'
CURSIVE='\033[3m'
WARNING='\033[33m'

all: $(NAME)

$(NAME): $(OBJS)
	@$(CC) $(OBJS) -o $@ $(CFLAGS)
	@echo $(GREEN)"- Compiled -"$(NONE)

$(OBJ_DIR)/%.o: %.cpp
	@echo $(CURSIVE)$(GRAY) "     - Building $<" $(NONE)
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@

lint:
	@echo $(CURSIVE)$(GRAY) "     - Running cppcheck" $(NONE)
	@cppcheck --enable=all --suppress=missingIncludeSystem --error-exitcode=1 .

format:
	@echo $(CURSIVE)$(GRAY) "     - Running clang-format" $(NONE)
	@find . -name '*.cpp' -o -name '*.h' | xargs clang-format -i

prepush: lint format
	@git diff --exit-code
	@make all

clean:
	@$(RM) $(OBJS) $(OBJ_DIR)
	@echo $(CURSIVE)$(GRAY) "     - Object files removed" $(NONE)

fclean: clean
	@rm -f $(NAME)
	@echo $(CURSIVE)$(GRAY) "     - $(NAME) removed" $(NONE)

re: fclean all

.PHONY: all clean fclean re lint format prepush
