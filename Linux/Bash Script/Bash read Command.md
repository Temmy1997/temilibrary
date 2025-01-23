# Bash Read Command 
* Read -  Used to read input from a user
* Its a bash command that reads the contents of a line into a variable 
* [read <Filename>]
* This input has to be stored in a varible [$Variable]
* Use man read to see the options of avaliable for the read command. 

## Example 1
echo Hello, who am i speaking to?
read NAME
echo Nice to meet you $NAME

## Example 2: Simplifying Code Using the "Prompt" Operator
#!/bin/bash
read -p "Please type your name" name
echo "Your name is" $name

## Exmaple 3:  Hiding the User Input Using the “secret/silent” Operator
* Use the -s option to hide the input of the user 
#!/bin/bash
read -p "Please type your username" username
read -s -p "Please type your password" $password

## Example 4: Limiting the Character Length
* Use the -n option to add a constraint to the number of characters that the user may input

#!/bin/bash
read –n 8 –p “Please type your username not exceeding 8 characters” username
echo “Your username is” $username

* To restrict the input length, the “-N” flag can be used, which limits the user’s response to exactly eight characters.

Link: https://linuxhint.com/use-read-command-bash/