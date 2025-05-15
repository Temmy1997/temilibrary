# AMAZON DATA FIREHOSE 
- Fully managed service 
- Sends real-time straming data from sources into target destination like (Amazon S3, Amazon Redshift, Amazon OpenSearch Service, and Splunk)
- automatical scaling 
- No data storage 

## SOURCES: ORIGIN OF THE STREAMING DATA 
- Kinesis Data Streams: To deliver data already being ingested by Kinesis Data Streams.
- AWS IoT Core: To deliver data from connected IoT devices.
- CloudWatch Logs: To deliver log data.
- Direct Put: Your applications can directly send data to the Firehose delivery stream.

## HOW IT WORKS 
1. Create a Firehose delivery stream, specifying the (source) and the (destination)
2. Data is ingested into the Firehose delivery stream from the configured source.
3. Firehose invokes your Lambda function to transform the data.
4. If configured, Firehose converts the data to the specified format (e.g., Parquet).
5. Firehose buffers the incoming data based on your configured buffering hints.
6. Firehose delivers the buffered data to the specified destination in batches.
7. If delivery fails, Firehose retries according to your configuration and can optionally send failed data to a backup S3 bucket.

## KEY CONCEPTS 
- Buffering: process of temporarily holding incoming data in memory or on disk before delivering it to the final destination.

