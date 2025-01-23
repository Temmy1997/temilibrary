# YAML (YAML Ain't Markup Language)
* Yaml is a human redeadble data serialization laguange. 
* Yaml is just like XML and JSON 
* Its used for writing configuraiton files 
* Line spacing and indentayion is v ery important in YAML 

## Syntax of YAML 
1. Key Value Pairs 
* We do not need quotes in key -value pair 

app: user-authentication 
port: 9000
version: 1.7 

2. Objects 
* We can create an objects 
  
Microservice:
    app: user-authentication 
    port: 9000
    version: 1.7 

3. List 
## List of Objects 
Microservice:
    - app: user-authentication 
      port: 9000
      version: 1.7 
    - app: shopping app
      port: 9002
      version: 1.2

## List of Simple value

microservice:
    - user-app
    - shopping-app 
## List inside of list 
Microservice:
    - app: user-authentication 
      port: 9000
      version:
        - 1.9
        - 2.0 
        - 3.5
    - app: user-authentication 
      port: 9000
      version:
        - 1.9
        - 2.0 
        - 3.5
## List in another way 
Microservice:
    - app: user-authentication 
      port: 9000
      version: [1.7, 2.0, 3.5] 

4. Booleans 
You can us true, false, yes, no , on , off 

Microservice:
    - app: user-authentication 
      port: 9000
      version: 1.7 
      deployed: true 
5. Multiline Strings 
## With line breaks 
## Yaml will interpret each line seprately 
Multilinestring: |
    This is the first line 
    And thsi si the second line 
    Next line
    Last line

6. Singlelinestring
## With long string that has to be on a single line 
## Yaml will interpret this lines as a single line 
Singlelinestring: >
    This is the first line,
    And this is the second line, 
    Next line,
    Last line.

7. Placeholders 
Syntax: {{}}
Microservice:
    app: {{user-authentication}} 

 8. Mutiple Yaml Document 
## --- is used to sepreate YAML document 

Microservice:
    - app: user-authentication 
      port: 9000
      version: 1.7 
      deployed: true
---
Microservice:
    - app: user-authentication 
      port: 9000
      version: 1.7 
      deployed: true

