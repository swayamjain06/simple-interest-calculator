#!/usr/bin/env bash

export LC_ALL=C

read_amount() {
    local prompt="$1"
    local value
    local decimal='^([0-9]+([.][0-9]*)?|[.][0-9]+)$'

    printf '%s' "$prompt" >&2
    if ! IFS= read -r value || [[ ! $value =~ $decimal ]]; then
        printf 'Enter a nonnegative number, such as 10 or 2.5.\n' >&2
        return 1
    fi

    printf '%s\n' "$value"
}

principal=$(read_amount 'Principal amount: ') || exit 1
rate=$(read_amount 'Annual rate of interest (%): ') || exit 1
years=$(read_amount 'Time period (years): ') || exit 1

awk -v principal="$principal" -v rate="$rate" -v years="$years" '
    BEGIN {
        interest = principal * (rate / 100) * years
        printf "Simple interest: %.2f\n", interest
    }
'
