# Bash Scripting - For Loop
* Bash is a command-line language 
* We use loops and conditional statements in Bash scripts to perfrom some repetitive problems in a simple programmatic way.

## Ways to use (For Loop)
1. Simple For loop
2. Range-based for loop
3. Array iteration for loops
4. C-Styled for loops
5. Infinite for loop
   
### Simple For loop 
     FOR EXAMPLE: 

#!/bin/bash

for n in a,b,c;
do 
    echo $n 
done 

### Range-based For Loop 
* We specify the number to start to number to stop. 
* We  use {} to specify a range of numbers 
  
        FOR EXAMPLE: 

for n in {1..5};
do 
    echo $n
done 

Another way to do this is menetioning the increment /decrement value 
  
for n in {1..5..2};
do 
    echo $n
done 
Note: The (2) is the incremental value 

## Aray-iteration for loops 
* We use special variables in bash 
* We use @ to access all the elements in the arrays
  
        FOR EXAMPLE 
#!/bin/bash

s=("football" "cricket" "hockey")
for n in ${s[@]};
do 
    echo $n
done

## C-Styled for loops 
ß