# Postgres Connection

The following steps were taken to create the connection between the kubernetes instance and our managed postgres instance.

1. First, create a kubernetes secret:

`kubectl -n cvat create secret generic postgres-secret \
  --from-literal=username=cvat_service \
  --from-literal=password=REDACTED \
  --from-literal=database=cvat`

2. Create a gcp service account (GSA) and kubernetes service account (KSA) to link through Workload Identity (a GCP service to bind KSAs and GSAs)

First, create the GSA:

`gcloud iam service-accounts create cvat-postgres-sa \
  --display-name="CVAT service account for postgres <-> gke auth"`

and apply to it the necessary Cloud SQL Client role:

`gcloud projects add-iam-policy-binding percipio-dev \
  --member="serviceAccount:cvat-postgres-sa@percipio-dev.iam.gserviceaccount.com" \
  --role="roles/cloudsql.client"`

Note: I had to manually go to the gcloud console to add the Cloud SQL Client role as it requested a condition for the command above. I also added the Log Writer permission so I can have this SA write logs later.

Next, create the KSA:

`kubectl apply -f service_account.yaml`

Bind them through GCP Workload Identity:

`gcloud iam service-accounts add-iam-policy-binding \
--role="roles/iam.workloadIdentityUser" \
--member="serviceAccount:percipio-dev.svc.id.goog[cvat/cvat-postgres-sa]" \
cvat-postgres-sa@percipio-dev.iam.gserviceaccount.com`

One last step to complete the binding: annotate the KSA so that autopilot can recognize it:

kubectl -n cvat annotate serviceaccount \
cvat-postgres-sa \
iam.gke.io/gcp-service-account=cvat-postgres-sa@percipio-dev.iam.gserviceaccount.com


Note the connection name: percipio-dev:us-east5:portal-dev.
