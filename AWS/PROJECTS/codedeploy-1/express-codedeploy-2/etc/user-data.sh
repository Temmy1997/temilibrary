curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs


sudo apt update
sudo apt install ruby-full
sudo apt install wget
# https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-ubuntu.html
wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto > /tmp/logfile

   aws ec2 create-tags --resources i-0e15661f69f6cbf8b --tags Key=name,Value=codedeploy-demo --region us-east-2
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install