# AMAZON KINESIS DATA STREAMS.
- Collect and store streaming data in real time.

## KEY CONCEPST 
- Producers: Applications that put data into the Kinesis data stream.
- Consumers: Applications that reads and process data from the Kinesis data stream.
They use Kinesis Cleient Library (KCL)
- SHARD: A shard is basically how big a data stream is. 


## How It Works (Simplified):
- Producers Send Data record  in real time to a Kinesis data stream. 
- Data is Sharded: Kinesis Data Streams uses the partition key to determine which shard the data record will be written to.
- Data is Stored Durably: The data record is durably stored and replicated within the chosen AWS Region.
- Consumers Read Data: Consumer applications use the KCL or AWS SDKs to connect to the data stream and read records from one or more shards.
- Real-Time Processing: Consumers process the data records as they arrive in real time.
- Multiple Consumers: Multiple independent consumer applications can read and process the same data stream concurrently without affecting each other's position in the stream.

## FEATURES 
- Data can be retained for up to 365days.
- Ability to reprocesss data by consumer.
- Data can't be deleted from Kinesis (until it's expires)
- Security: At-rest KMS encryption, in-flight HTTPS encryption. 

## CAPACITY MODES 
apacity modes that determine how you manage and pay for the throughput of your data stream: 

1. Provisioned Mode 
- Choose the number of shards.
- Scale manaually to increase or decrease the number of shards. 
- Pay hourly for each shard in your data stream

2. On-Demand Mode:
- On-Demand mode dynamically scales Amazon Kinesis Data Streams based on your throughput needs. 
- AWS automatically manages the number of shards for your data stream based on the actual throughput of your application.
- You don't need to provision or manage shards.
- Billed per GB of data written to and read from your data stream. 
