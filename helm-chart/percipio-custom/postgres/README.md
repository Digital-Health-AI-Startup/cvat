# Connecting to our postgres instance


First, create a kubernetes secret:

kubectl create secret generic -n cvat postgres-secret \
  --from-literal=username=cvat_service \
  --from-literal=password=<YOUR-DATABASE-PASSWORD> \
  --from-literal=database=cvat

Note the connection name: percipio-dev:us-east5:portal-dev