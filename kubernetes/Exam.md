## Create a service messaging-service to expose the messaging application within the cluster on port 6379.

kubectl expose pod messaging --port=6379 --name messaging-service
service/messaging-service exposed

## Create static pod 
 k run static-busybox --image=busybox --dry-run=client -o yaml --command -- sleep 1000  > static.yaml

## To make the pod a static pod 
 Move the static.yaml file to /etc/kubenetes/manaifest 