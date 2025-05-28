
#### What is container orchestration, and what are its benefits?
**Container orchestration** is the automated process of managing, deploying, scaling, networking, and maintaining containers in a system. It streamlines the complexities of running multiple containers across different environments, ensuring efficient resource utilization, reliability, and scalability. Key benefits include optimized system performance, simplified management of containerized applications, and enhanced fault tolerance, which makes it indispensable for modern applications.


#### What is Kubernetes, and what is its main role?
**Kubernetes** is an open-source platform for container orchestration. Its main role is to automate the deployment, scaling, and operations of application containers across clusters of machines. Kubernetes provides features like load balancing, self-healing, storage orchestration, and configuration management, making it a powerhouse for managing containerized workloads efficiently.

#### What is K3s, and what is its main role?
**K3s** is a lightweight, simplified version of Kubernetes designed for edge computing, IoT, and resource-constrained environments. Its main role is to offer an easy-to-install and maintain Kubernetes solution without compromising essential features, enabling faster deployment and better performance in scenarios where minimal overhead is crucial. It’s often favored for smaller-scale setups compared to full-scale Kubernetes clusters.

#### What is infrastructure as code and what are the advantages of it?
**Infrastructure as Code (IaC)** is the practice of managing and provisioning computing infrastructure using machine-readable configuration files, rather than physical hardware setups or manual processes. IaC allows developers and operators to define the desired state of their infrastructure and automate its deployment and maintenance. 

**Advantages of IaC**:
- **Consistency**: Eliminates human error and ensures that environments are identical across development, testing, and production.
- **Automation**: Speeds up deployment processes and reduces manual effort.
- **Version Control**: Changes to infrastructure can be tracked, enabling easy rollbacks and audits.
- **Scalability**: Supports rapid scaling of resources as needed.
- **Collaboration**: Facilitates better collaboration among teams by using shared definitions for infrastructure.

#### Explain what is a K8s manifest.
**Kubernetes (K8s) manifest** refers to the configuration files written in YAML or JSON that define the desired state of resources in a Kubernetes cluster. It acts as the blueprint for deploying applications and configuring services, pods, or other components. Manifest files are used to declare the specifications that Kubernetes uses to ensure that the actual state matches the defined state.

#### Explain what is a K8s manifest.
**Types of Kubernetes manifests**:
1. **Pod Manifest**: Defines the specifications for running one or more containers together as a pod. It includes details like container images, resource requirements, and volumes.

2. **Deployment Manifest**: Used to declare how applications are deployed and updated. It provides details like the number of replicas, rollout strategy, and container template specifications.

3. **Service Manifest**: Specifies how a group of pods should be accessed. It defines the networking behavior, such as port configurations and load balancing.

4. **Ingress Manifest**: Configures HTTP and HTTPS routing to services within the cluster. It's useful for exposing applications externally.

5. **ConfigMap Manifest**: Allows the storage of configuration data as key-value pairs, which can be consumed by pods at runtime.

6. **Secret Manifest**: Stores sensitive information such as passwords, API keys, or certificates securely.

7. **Volume Manifest**: Declares storage resources that pods can use, such as Persistent Volumes or ephemeral storage.

#### What is StatefulSet in K8s?
**StatefulSet in Kubernetes (K8s)** is a workload API object designed for managing stateful applications. These are applications that require stable identities or persistent storage, like databases or distributed systems. StatefulSets ensure consistent naming, networking, and storage for pods, meaning each pod maintains its own identity and data even if rescheduled or restarted.

#### What is deployment in K8s?
**Deployment in Kubernetes (K8s)** is another workload API object used for stateless applications or applications that do not depend on retaining their state. Deployments are ideal for apps that scale horizontally (adding replicas) and need updates rolled out in a controlled way. They handle rolling updates, rollback of versions, and ensuring that a specific number of pods are always running.

#### What is the difference between deployment and StatefulSet in K8s?
**Difference Between Deployment and StatefulSet**:
- **Pod Identity**: Deployments create interchangeable pods, while StatefulSets maintain unique identities for each pod.
- **Storage**: Deployments usually work with ephemeral storage, while StatefulSets provide persistent storage, ensuring data survives restarts.
- **Use Case**: Deployments are suitable for stateless applications like web servers, while StatefulSets are better for stateful apps like databases.

#### What is scaling, and why do we use it?
**Scaling** refers to the process of adjusting the number of instances (or replicas) of a service or application to meet demand or optimize resource utilization. Scaling can be **horizontal** (adding/removing pods) or **vertical** (increasing/decreasing resources like CPU/RAM). It's essential to ensure the application handles increased traffic or workload efficiently.

#### What is a load balancer, and what is its role?
**Load Balancer** is a tool or resource that distributes incoming network traffic across multiple servers or pods. Its role is to:
- **Improve Availability**: Ensures the application remains operational by balancing loads among instances.
- **Optimize Performance**: Avoids overloading specific instances and ensures requests are served quickly.
- **Fault Tolerance**: Redirects traffic away from failed or unhealthy pods/servers.

#### Why we don't put the database as a deployment?
**Why not use Deployments for Databases**:
Databases often require persistent storage and stable pod identities, which deployments cannot guarantee. Deployments assume ephemeral pods that can be replaced freely, potentially leading to data loss or complications in database operations. For databases, **StatefulSets** are preferred because they provide unique identifiers and ensure data remains intact even if pods are rescheduled.
