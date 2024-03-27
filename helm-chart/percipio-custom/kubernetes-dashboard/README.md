# Instructions on setting up K8s Dashboard

## Deploy kubernetes-dashboard
To deploy the dashboard and all of it's associated resources, run the following command:

`kubectl apply -f ./helm-chart/percipio-custom/kubernetes-dashboard/deploy.yaml`

## Dashboard Access:

- Make sure you're logged in to your gcloud cli: `gcloud auth application-default login`
- Make sure you're current credentials are recognized by kubectl: `gcloud container clusters get-credentials percipio-dev --location us-east5`
- Run `kubectl proxy` making sure that your kubectl context is set to our gke cluster
- Go to this url once proxy is running: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
- Generate a token by running command: `kubectl -n kubernetes-dashboard create token admin-user` and paste into browser