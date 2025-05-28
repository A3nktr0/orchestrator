$KUBECONFIG = "./k3s/k3s.yaml"

function Show-Help {
    @"
orchestrator CLI v0.0.1

Manage a Kubernetes cluster in a VM kluster running K3s

USAGE:
./orchestrator.ps1 COMMAND

Available commands:
    create  Create the VM cluster using the local Vagrantfile config
    start   Start the Kubernetes cluster on the VM cluster
    stop    Stop the Kubernetes cluster on the VM cluster
    clean   Remove cluster and resource
"@
}

if ($args.Count -ne 1) {
    Show-Help
    exit 1
}

switch ($args[0]) {
    "create" {
        Write-Output "create resources"
        vagrant up --provision
    }
    "start" {
        Write-Output "start cluster"
        # Start the VMs
        vagrant up
    }
    "stop" {
        Write-Output "stop cluster"
        vagrant suspend
    }
    "clean" {
        Write-Output "remove cluster and resources"
        vagrant destroy -f
        Remove-Item -Recurse -Force ./k3s
    }
    default {
        Write-Output "$($args[0]) is an unknown command"
        Show-Help
        exit 1
    }
}