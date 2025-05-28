# Orchestrator

## Prerequisites

Before starting, ensure you have the following installed on your machine:

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Docker](https://www.docker.com/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- A [Docker Hub](https://hub.docker.com/) account to push your Docker images.

## Configuration

1. **K3s Cluster**:
   - Create two virtual machines using Vagrant:
     - `Master`: The master node in the K3s cluster.
     - `Agent`: An agent node in the K3s cluster.
   - Ensure the nodes are connected and available.

   ```console
   $> kubectl get nodes -A
   NAME            STATUS   ROLES    AGE    VERSION
   <master-node>   Ready    <none>   XdXh   vX
   <agent1-node>   Ready    <none>   XdXh   vX
   ```

2. **Secrets**:
   - Store all passwords and credentials as Kubernetes secrets.
   - Do not include sensitive information directly in the YAML manifests.

3. **Docker Images**:
   - Build and push Docker images for each component to Docker Hub.

## Setup

1. Clone the repository and navigate to the project directory.

2. Run the `orchestrator.sh` script to create and manage the infrastructure:

   ```console
   $> ./orchestrator.sh create
   cluster created
   $> ./orchestrator.sh start
   cluster started
   $> ./orchestrator.sh stop
   cluster stopped
   ```

3. Deploy the Kubernetes manifests for all components:
   - Databases (`inventory-database` and `billing-database`) as StatefulSets with persistent volumes.
   - Applications (`inventory-app`, `billing-app`, and `api-gateway-app`) as Deployments or StatefulSets as specified in the project requirements.

4. Configure Horizontal Pod Autoscalers (HPA) for:
   - `api-gateway`: max replication: 3, min replication: 1, CPU percent trigger: 60%.
   - `inventory-app`: max replication: 3, min replication: 1, CPU percent trigger: 60%.

## Usage

1. Access the services:
   - `inventory-app`: Accessible via port `8080`.
   - `billing-app`: Accessible via port `8080`.
   - `api-gateway-app`: Accessible via port `3000`.

2. Monitor the cluster using `kubectl` commands:
   ```console
   $> kubectl get pods
   $> kubectl get services
   ```

3. Push updates to Docker Hub and redeploy manifests as needed.


#### Tips
To stop a statefulset container, decrease replicas to 0 :
```
$ kubectl scale statefulset billing-app --replicas=0
```
to start it again, increase the replicas to 1:
```
$ kubectl scale statefulset billing-app --replicas=1
```