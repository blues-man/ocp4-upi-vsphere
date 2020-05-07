######VARIABLES#####
export GOVC_URL=''
export GOVC_USERNAME=''
export GOVC_PASSWORD=''
export GOVC_INSECURE=1

CLUSTER_NAME=""
CLUSTER_DOMAIN=""
RHCOS_TEMPLATE="rhcos-4.3.8"

VM_NETWORK=""
VM_DATASTORE=""
VM_DATACENTER=""
VM_FOLDER=""

BOOTSTRAP_MAC='00:50:56:23:F7:21'
BOOTSTRAP_NAME='bootstrap'

MASTER0_MAC='00:50:56:1E:A5:6A'
MASTER0_NAME='master0'

MASTER1_MAC='00:50:56:1E:33:25'
MASTER1_NAME='master1'

MASTER2_MAC='00:50:56:0C:F8:E0'
MASTER2_NAME='master2'

WORKER0_MAC='00:50:56:1E:2C:5D'
WORKER0_NAME='worker0'

WORKER1_MAC='00:50:56:24:CD:19'
WORKER1_NAME='worker1'

###############################

echo "Set disk.EnableUUID to true for template"

./govc vm.change -e="disk.enableUUID=1" -vm="/${VM_DATACENTER}/vm/${RHCOS_TEMPLATE}"

echo "Deploying - Bootstrap node"
bootstrap=$(cat append-bootstrap.ign | base64 -w0)
./govc vm.clone -vm ${RHCOS_TEMPLATE} -annotation=BootstrapNode -c=4 -m=16384 -net ${VM_NETWORK} -net.address ${BOOTSTRAP_MAC} -on=false -folder=${VM_FOLDER} -ds=${VM_DATASTORE} ${BOOTSTRAP_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.change -e="guestinfo.ignition.config.data=${bootstrap}" -vm=${BOOTSTRAP_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.power -on=true ${BOOTSTRAP_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}

echo "Deploying - Master0 node"

master=$(cat master.ign | base64 -w0)
./govc vm.clone -vm ${RHCOS_TEMPLATE} -annotation=MasterNode00 -c=4 -m=16384 -net ${VM_NETWORK} -net.address ${MASTER0_MAC} -on=false -folder=${VM_FOLDER} -ds=${VM_DATASTORE} ${MASTER0_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.change -e="guestinfo.ignition.config.data=${master}" -vm=${MASTER0_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.power -on=true ${MASTER0_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}


echo "Deploying - Master1 node"

master=$(cat master.ign | base64 -w0)
./govc vm.clone -vm ${RHCOS_TEMPLATE} -annotation=MasterNode01 -c=4 -m=16384 -net ${VM_NETWORK} -net.address ${MASTER1_MAC} -on=false -folder=${VM_FOLDER} -ds=${VM_DATASTORE} ${MASTER1_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.change -e="guestinfo.ignition.config.data=${master}" -vm=${MASTER1_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.power -on=true ${MASTER1_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}

echo "Deploying - Master2 node"

master=$(cat master.ign | base64 -w0)
./govc vm.clone -vm ${RHCOS_TEMPLATE} -annotation=MasterNode02 -c=4 -m=16384 -net ${VM_NETWORK} -net.address ${MASTER2_MAC} -on=false -folder=${VM_FOLDER} -ds=${VM_DATASTORE} ${MASTER2_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.change -e="guestinfo.ignition.config.data=${master}" -vm=${MASTER2_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.power -on=true ${MASTER2_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}

echo "Deploying - Worker0 node"

worker=$(cat worker.ign | base64 -w0)
./govc vm.clone -vm ${RHCOS_TEMPLATE} -annotation=WorkerNode00 -c=4 -m=16384 -net ${VM_NETWORK} -net.address ${WORKER0_MAC} -on=false -folder=${VM_FOLDER} -ds=${VM_DATASTORE} ${WORKER0_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.change -e="guestinfo.ignition.config.data=${worker}" -vm=${WORKER0_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.power -on=true ${WORKER0_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}


echo "Deploying - Worker1 node"

worker=$(cat worker.ign | base64 -w0)
./govc vm.clone -vm ${RHCOS_TEMPLATE} -annotation=WorkerNode01 -c=4 -m=16384 -net ${VM_NETWORK} -net.address ${WORKER1_MAC} -on=false -folder=${VM_FOLDER} -ds=${VM_DATASTORE} ${WORKER1_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.change -e="guestinfo.ignition.config.data=${worker}" -vm=${WORKER1_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.power -on=true ${WORKER1_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}

echo "Deploying - Worker2 node"

worker=$(cat worker.ign | base64 -w0)
./govc vm.clone -vm ${RHCOS_TEMPLATE} -annotation=WorkerNode02 -c=4 -m=16384 -net ${VM_NETWORK} -net.address ${WORKER2_MAC} -on=false -folder=${VM_FOLDER} -ds=${VM_DATASTORE} ${WORKER2_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.change -e="guestinfo.ignition.config.data=${worker}" -vm=${WORKER1_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
./govc vm.power -on=true ${WORKER1_NAME}.${CLUSTER_NAME}.${CLUSTER_DOMAIN}
