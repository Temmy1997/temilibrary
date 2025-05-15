# AMAZON SNS (SIMPLE NOTIFICATION SYSTEM)
- Amazon Simple Notification Service (SNS) is a fully managed messaging service from AWS
- It send notifications to a large number of subscribers.

SNS works on a "publish-subscribe" (pub/sub) model:

 1. Publishers (Event Producers): Creates and sends messages to one SNS topic.

 2. Subscribers (Event Consumers): Receives messages from a particular topic. 

 - Each sunscribers to the topic will get all the messages 

 - Up to 12,500,000 subscription per topic. 

 3. Topics: A topic is like a communication channel or a named logical access point. When a publisher has a message to send, it sends it to a specific topic. 

 - Has 100,000 topic limit
 
 ## Amazon SNS Security 
 1. Encryption (Protecting the Data)
- In-flight encryption using HTTPS API 
-  At-rest encryption using KMS keys. 
- Client side encryption, if the client wants to perform encrption/decryption by ifself. 

2. Access Conrols:
IAM POLICIES to regulates access to SNS API

3. SNS Access polices (Similar to s3 bucket polices)

## What you need to know about SNS 
- Pushes data to many subscribers.
- 