# Author: Richard Galvez
# Date: 2023-03-14
# Purpose: Script that outlines how initial deployment of a helm chart was done
#   to be moved to a CI/CD pipeline.

# Reference: https://opencv.github.io/cvat/docs/administration/advanced/k8s_deployment_with_helm/
# First be sure to update the helm installations by running `helm dependency build`

# helm upgrade -n <desired_namespace> <release_name> -i --create-namespace ./helm-chart -f ./helm-chart/values.yaml -f ./helm-chart/values.override.yaml

helm upgrade -n cvat cvat-dev -i --create-namespace ./helm-chart -f ./helm-chart/values.yaml -f ./helm-chart/percipio-helm-overrides.yaml

# To create the cvat admin user:
kubectl exec -it --namespace cvat $BACKEND_POD_NAME -c cvat-backend-app-container -- python manage.py createsuperuser

# To get backend pod name, run kubectl get pods -n cvat and find the one with the 'backend-server' string
# For example:
kubectl exec -it --namespace cvat cvat-dev-backend-server-6c676d9947-6wlsc -c cvat-backend -- python manage.py createsuperuser


# The following lines were used to deploy the managed kubernetes cluster:

# Note: Autopilot clusters must be regional clusters, cannot be zonal unfortunately.
gcloud container clusters create-auto percipio-dev --location us-east5