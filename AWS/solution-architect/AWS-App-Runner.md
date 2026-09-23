# AWS APP RUNNER 
- Fully managed container application service.
- It makes it easy to automatically deploy web apps and APIs at scale with no infrastructure experience required.
- Automatic scaling, highly available, load balancer , encryption.

## How it Works (Simplified):
1. Start with source code in your repo or container image (This tells the  App Runner where to find your source code/Docker container image (usually in Amazon ECR).
2. Configure some basic settings (like which port your application uses), and App Runner takes care of deploying your container.
3. It's live! Your application is now accessible
4. Use the public URL provided by App Runner to access the application. 

App Runner manages it: It automatically scales, load balances, and monitors your application's health.

# AWS App2Container (A2C)
* It is a CLI tool used to migrate JAVA & .NET web apps into Dockr containers.
## LIFT-AND-SHIFT MIGRATION
- A2C does a lift-and-shift migration of your apps running on-prem into AWS. 
- Migrating your apps into cloud without no code changes.
