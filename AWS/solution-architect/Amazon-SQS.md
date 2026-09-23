# AMAZON SIMPLE QUEUE SERRVICE (SQS)
******                                                
Imagine you have two applications that need to communicate. Instead of them talking directly to each other, they use a "message queue." Think of it like a mailbox or a waiting line.
******

- SQS is that mailbox/waiting line. It's a service that allows applications to send and receive messages without needing to know anything about each other.

Producers -->> SQS Queue -->> Consumers 

*** Producers send messages into the SQS QUEUE ***
*** consumers will poll the messages from the queue and get the information. ***

*** So the Queueing service decoupole between the producers and the consumer. *** 

## Key Concepts 
- Queues:

        These are the "mailboxes" or "waiting lines" where messages are stored

- Messages:

    1. These are the data that applications want to exchange.
    2. They can contain any kind of information, like text, numbers, or even code.

- Producers

        A "producer" application sends messages to the queue.

- Consumers

        A "consumer" application retrieves messages from the queue and processes them.

- Decoupling

        SQS "decouples" applications, meaning they don't have to be running at the same time or know each other's details.


## What you need to know about SQS
* One of the 1st services in AWS.
* Fully managed service.
* Used to decouple applications. 
* Ordering garantee on FIFO queue.
* Data is deleted after been consumed. 

1. ATTRIBUTES 
    - No limit to the number of message in the SQS Queue.
    - By default, message stay in the queue for 4days, and maximum of 14days.
    - It has low latency (Very quick response time when you send a message and when you wnat to recive a message)
    - Less that 256kb per message sent.

2. At least one delivery, (That means you might have duplicte message)


## SQS - PRODUCING MESSSAGES (PRODUCERS)

- Producers sends message to SQS using SDK (SOFTWARE DEVELOPMENT KIT) 

    *** API TO SEND MESSAGE TO SQS IS CALLED SEND MESSAGE ***

- The messages will be written into the SQS Queue until a cuonsumer reads the message and delete it.
- Messages stays in the SQS for at least 4 days and maximin 14 days. 

## SQS - COMSUMING MESSAGES (CONSUMERS)
- Cosumers are the applications.
- The app can running on EC2 INSTNACES, servers, Lambda functions. 
- Comsumers pulls SQS for messages.
- Consumers may recaive up to 10 messages at a time.
- Consumers will process the messages. {E.X Insert messages into an RDS database}
- Consumer will delete the messages using (DeleteMessage API).

## SQS with Auto Scaling Group (ASG)
- Consumers will be runnign on EC2 Instances inside of an AUTOSCALING GROUP.
- EC2 instances, managed by the ASG, constantly check the SQS queue for new messages and process the tasks they find.
- Monitoring the Queue: You configure a way to monitor the number of messages in the SQS queue (this is often done using Amazon CloudWatch metrics like ApproximateNumberOfMessagesVisible).
- The CloudWatch metrics is found in any SQS QUEUE. 
- You set up scaling policies within your ASG that tell it when to add or remove EC2 instances based on the queue size.
- An alarm can be set in the CloudWatch Metrics to trigger a scaling action in ASG  to scale up more EC2 instances. 

## SQS SECURITY 
1. Encryption (Protecting the Data)
- In-flight encryption using HTTPS API 

*** {applications send or receive messages from SQS over the internet,}***

- At-rest encryption using KMS keys. 

*** {SQS uses encryption keys managed by AWS Key Management Service (KMS) to encrypt your messages. } ***

- Client side encryption, if the client 

2. Access control: Identity and Access Management (IAM)
- Primary way to control who can interact with SQS queue. 
- You can create IAM users, groups, and roles, and then attach policies to them that define specific permissions for SQS actions.

3. SQS Access policies {Similar to S3 policies}

## AMAZON SQS - Long Polling 
- When a concumer request messages from the queue, it can optionally "wait" for the messages to arrive if there is no message in the queue. 

- If any new messages arrive during this time, the consumer will collec the messages. 

- It decreaces the number of API calls made to SQS. 
- It reduces the latency of the applications. 
Wait time 1 seconds to 20 second

## AMAZON SQS FIFO QUEUE
- FIFO {FIRST IN FIRST OUT}

- Messages are delivered to consumers in the precise order they were sent by producers.

- If you send Message A, then Message B, consumers will always receive Message A before Message B. 

-   

## SQS VISIBILITY TIMOUT 
- This is a period of time during which SQS prevent other consumers from reciving and processing messages agin. 

- In visibility timout a message is hidden only after iyt is consumed from the queue.

- Increainf the visibility - Goves more time to the consumers to process the messagesd and prevents duplicates reading of the messafes