#!/bin/bash

contains_uppercase() {
    [[ "$1" =~ [A-Z] ]]
}

contains_lowercase() {
    [[ "$1" =~ [a-z] ]]
}

contains_numbers() {
    [[ "$1" =~ [0-9] ]]
}

contains_special() {
    [[ "$1" =~ [\!\@\#\$\%\^\&\*\(\)\-\+\=\{\}\[\]\|\:\;\"\'\<\>\,\.\?\/\\] ]]
}

check_password_strength() {
    local password="$1"
    local length=${#password}
    local score=0

    if [ "$length" -ge 8 ]; then
        (( score += 20 ))
    elif [ "$length" -ge 6 ]; then
        (( score += 10 ))
    else
        echo "Password length should be at least 6 characters."
        exit 1
    fi

    if contains_uppercase "$password"; then
        (( score += 20 ))
    fi

    if contains_lowercase "$password"; then
        (( score += 20 ))
    fi

    if contains_numbers "$password"; then
        (( score += 20 ))
    fi

    if contains_special "$password"; then
        (( score += 20 ))
    fi

    echo "Password strength: $score%"
}

read -s -p "Enter your password: " password
echo

check_password_strength "$password"
