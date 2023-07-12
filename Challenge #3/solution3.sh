#!/bin/bash

# Function to get value from nested object
get_value_nested_object() {
  local -n obj=$1
  local key=$2

  IFS='/' read -ra keys <<< "$key"
  local value=${obj}

  for k in "${keys[@]}"; do
    value=${value[$k]}
  done

  echo "$value"
}

# Example usage
# Define a nested object
declare -A my_object={“a”:{“b”:{“c”:”d”}}}

# Call the function to get the value for a key
result=$(get_value_nested_object my_object "a/b/c")
echo "Value: $result"
