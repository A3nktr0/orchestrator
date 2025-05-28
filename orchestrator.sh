#!/bin/bash

KUBECONFIG="./k3s/k3s.yaml"

function show_help() {
	cat <<EOF
orchestrator CLI v0.0.1

Manage a Kubernetes cluster in a VM kluster running K3s

USAGE:
./orchestrator.sh COMMAND

Available commands:
	create  Create the VM cluster using the local Vagrantfile config
	start   Start the Kubernetes cluster on the VM cluster
	stop    Stop the Kubernetes cluster on the VM cluster
	clean   Remove cluster and resource
EOF
}

if [[ $# -ne 1 ]]; then
	show_help
	exit 1
fi

case $1 in
	"create")
		echo "create resources"
		vagrant up --provision
		;;
	"start")
		echo "start cluster"
		# Start the VMs
		vagrant up
		;;
	"stop")
		echo "stop cluster"
		vagrant suspend
		;;
	"clean")
		echo "remove cluster and resources"
		vagrant destroy -f
		rm -rf ./k3s
		;;
	*)
		echo "$1 is an unknown command"
		show_help
		exit 1
		;;
esac
