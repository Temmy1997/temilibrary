#!/bin/bash

read -p "Enter first number: " num1
# prompts the user to enter the first number and stores it in the variable num1
read -p "Enter second number: " num2
# prompts the user to enter the second number and stores it in the variable num2
read -p "Enter operator (+, -, *, /): " op
# prompts the user to enter the desired operator (+, -, *, /) and stores it in the variable op

case "$op" in
# execute different code blocks based on the value of the variable op.
  "+") # If the operator is +, it executes the following code
    echo "Result: $((num1 + num2))" ;; 
  "-")  # If the operator is -, it executes the following code:
    echo "Result: $((num1 - num2))" ;; # 
  "*") # If the operator is *, it executes the following code
    echo "Result: $((num1 * num2))" ;;
  "/") # If the operator is /, it executes the following code:
    if [[ $num2 -eq 0 ]]; then
      echo "Error: Division by zero"
    else
      echo "Result: $((num1 / num2))"
    fi
    ;;
  *) 
    echo "Invalid operator" ;; # If the operator is none of the above (+, -, *, /), it executes the following code
esac