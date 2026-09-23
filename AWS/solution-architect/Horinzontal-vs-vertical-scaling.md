# HORINZONATL VS VERTICAL
*  When dealing with cloud computing, especially within AWS, understanding scaling is crucial. Here's a simplified explanation of horizontal and vertical scaling:

## Vertical Scaling (Scaling Up/Down):

* Vertical scaling involves increasing or decreasing the resources of a single server or instance.
* Think of it as upgrading your computer: you add more RAM, a faster CPU, or more storage.
## In AWS:
* This typically involves changing the instance type of an EC2 instance. For example, moving from a "t2.micro" to a "t2.large" instance.
## Pros:
* Simple to implement.
* Often suitable for applications that rely on a single server, like some databases.
## Cons:
* Limited by the maximum capacity of a single machine.
* Can require downtime during upgrades.

## Horizontal Scaling (Scaling Out/In):
* Horizontal scaling involves adding or removing more servers or instances to distribute the workload.
* Think of it as adding more computers to a network to handle increased demand.
## In AWS:
* This is often achieved using services like EC2 Auto Scaling and Elastic Load Balancing (ELB).
* Auto Scaling automatically adds or removes EC2 instances based on demand.
* ELB distributes incoming traffic across multiple instances.
## Pros:
* Highly scalable and flexible.
* Improves fault tolerance: if one instance fails, others can take over.
* Can handle large and fluctuating workloads.
## Cons:
* More complex to implement than vertical scaling.
* Requires careful design to ensure data consistency and session management.
