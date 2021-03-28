#!/bin/bash

source include/colors.sh

## Accept user input
##
## $1: Is this a Yes/No question?
## $2: Prompt Text
## $3: Default value
## $4: Accepted Pattern (Only used in simple input)
##
## Input from user is saved in $RESULT variable
read_input() {
    while true; do
        read -e -p "$2" -i "$3" input
        if [[ $1 = true ]]; then
            case $input in
                [Yy]* ) RESULT=1; break;;
                [Nn]* ) RESULT=0; break;;
                * ) tput cuu 1; tput cuf ${#2}; echo "${YELLOW}Only accpet yes/no.${RESET}";;
            esac
        else
            case $input in
                "" ) tput cuu 1; tput cuf ${#2}; echo "${YELLOW}Empty input.${RESET}";;
                $4 ) RESULT=$input; break;;
                * ) tput cuu 1; tput cuf ${#2}; echo "${YELLOW}Invalid input.${RESET}";;
            esac
        fi
    done
}
