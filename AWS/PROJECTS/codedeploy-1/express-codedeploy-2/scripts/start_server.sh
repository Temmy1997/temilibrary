echo "Starting the server"

sudo npm install --prefix /home/ubuntu/Code/express-codedeploy-2
npm run build --prefix /home/ubuntu/Code/express-codedeploy-2
sudo systemctl restart node-api.service