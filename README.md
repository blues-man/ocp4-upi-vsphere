# ocp4-upi-vsphere
Sample script for OCP4 UPI installation on vSphere

## Usage

Follow documentation on how to generate Ignition file needed for Installationi from OVA image:
https://docs.openshift.com/container-platform/4.4/installing/installing_vsphere/installing-vsphere.html#installation-user-infra-generate-k8s-manifest-ignition_installing-vsphere

This will create 6 Nodes, 3 Master and 3 Worker as standard topology.

Fill vCenter and all needed details in the script:

```
$ ./create.sh
```



