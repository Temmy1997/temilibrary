# Amazon MQ
- Amazon MQ is a managed message broker service for Apache ActiveMQ and RabbitMQ 
- It makes it easy to set up and operate message brokers in the cloud, so you can migrate your messaging and applications from on-prem to cloud without rewriting code.
- MQ does not scale like (SNS OR SQS)
- MQ can run on servers and multi AZ. 

A
## Active/standby setup with EFS
Active/standby setup with EFS provides automatic failover and data persistence. 
Single-instance does not.

### Amazon MQ Failover with EFS (Active/Standby):
- Failure: Active broker goes down.
- Action: Standby broker automatically becomes active.
- EFS Role: Standby mounts the shared EFS volume where messages are stored.
- Result: Message processing resumes with minimal data loss after a short downtime. Clients need to reconnect.

### Amazon MQ Failover with EFS (Single-Instance):
- Failure: Broker goes down.
- Action: No automatic failover. Manual intervention needed.
- Downtime: Significantly longer.



