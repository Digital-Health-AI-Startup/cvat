# Kubernetes Cluster with CVAT

Before deploying a new gke cluster, make sure you are logged in to gcp with the correct credentials:
`gcloud auth application-default login`

The following lines were used to deploy the managed kubernetes cluster:

Note: Autopilot clusters must be regional clusters, cannot be zonal unfortunately.
`gcloud container clusters create-auto percipio-dev --location us-east5`

After this, to authenticate your kubectl with the cluster, run the following command:

`gcloud container clusters get-credentials percipio-dev --location us-east5`

Note: if you need information on installing kubectl for your operating system, please see https://kubernetes.io/docs/tasks/tools/. It's also recommended that you install Helm: https://helm.sh/docs/helm/helm_install/

# CVAT

For official read me from CVAT, that was mostly followed for this deployment, please
[see here for details.](https://opencv.github.io/cvat/docs/administration/advanced/k8s_deployment_with_helm/)

First be sure to update the helm installations by running the following in the ./helm-charts directory:

`helm dependency build`

## Deployment

To deploy CVAT, run the following command adjusting for your use case. You shouldn't have to redeploy this.

`helm upgrade -n <desired_namespace> <release_name> -i --create-namespace ./helm-chart -f ./helm-chart/values.yaml -f ./helm-chart/values.override.yaml`

The exact command that was used for the current deployment is:

`helm upgrade -n cvat cvat-dev -i --create-namespace ./helm-chart -f ./helm-chart/values.yaml -f ./helm-chart/percipio-custom/helm-overrides.yaml`

To create the cvat admin user:
`kubectl exec -it --namespace cvat $BACKEND_POD_NAME -c cvat-backend-app-container -- python manage.py createsuperuser`

To get backend pod name, run kubectl get pods -n cvat and find the one with the 'backend-server' string
For example:

`kubectl exec -it --namespace cvat cvat-dev-backend-server-7b8bbd478b-bnqp9 -c cvat-backend -- python manage.py createsuperuser`