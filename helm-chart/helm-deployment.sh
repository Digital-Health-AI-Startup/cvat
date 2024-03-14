# Author: Richard Galvez
# Date: 2023-03-14
# Purpose: Script that outlines how initial deployment of a helm chart was done
#   to be moved to a CI/CD pipeline.

# Reference: https://opencv.github.io/cvat/docs/administration/advanced/k8s_deployment_with_helm/
# First be sure to update the helm installations by running `helm dependency build`

# helm upgrade -n <desired_namespace> <release_name> -i --create-namespace ./helm-chart -f ./helm-chart/values.yaml -f ./helm-chart/values.override.yaml

helm upgrade -n cvat cvat-dev -i --create-namespace ./helm-chart -f ./helm-chart/values.yaml -f ./helm-chart/percipio-helm-overrides.yaml