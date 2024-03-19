# Custom storage class for FileStore instance

The standard-rwx file store storage class that comes default with autopilot clusters never produces a bound volume as it may be waiting for the manual creation of a filestore managed drive.

In order to automate the provisioning, and decommissioning of all resources needed including the managed filestore volume, we needed to create a custom storage class which effectively only overwrites the default volumeBindingMode to `volumeBindingMode: Immediate`.

To add this custom storage class to our cluster first make sure the cluster has been created and you are properly logged in by following instructions in main ./helm-chart readme. Then, run the following kubectl command:

`kubectl apply -f ./helm-chart/percipio-custom/filestore-custom-storageclass/storageclass.yaml