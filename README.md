# Nginx Proxy Manager Helm Chart

This repository provides a Helm chart to easily deploy [Nginx Proxy Manager](https://nginxproxymanager.com/) on Kubernetes. The chart is designed to be flexible and customizable, allowing you to configure values such as passwords, image versions, service types, and more.

## Installation Instructions

Follow these steps to install the Nginx Proxy Manager Helm chart and customize your deployment.

### Step 1: Add the Helm Repository

To add the Nginx Proxy Manager Helm chart repository to your Helm client, run the following commands:

```bash
helm repo add nginxproxymanager https://brnl.github.io/nginxproxymanager-helm/
helm repo update
```

### Step 2: Modify the `values.yaml` (Important!)

> **Note:** _Be sure to change the default passwords to something secure!_
> Make sure to change the `rootPassword`, `user`, and `password` under the `mariadb.env` section to secure your database.

You can customize your deployment by modifying the `values.yaml` file before installation. The most commonly changed values are the database and application passwords.

# Helm Values for Nginx Proxy Manager Deployment

The following table outlines the configuration options available for deploying Nginx Proxy Manager using Helm. You can customize these values to fit your requirements.

| **Parameter**                | **Description**                                                            | **Default Value**            |
|------------------------------|----------------------------------------------------------------------------|------------------------------|
| `namespaceOverride`           | The namespace where resources will be deployed.                             | `""` (empty)                 |
| **Nginx Configuration**       |                                                                            |                              |
| `nginx.replicas`              | Number of replicas (instances) of Nginx Proxy Manager.                     | `1`                          |
| `nginx.image.repository`      | Docker image repository for Nginx Proxy Manager.                           | `jc21/nginx-proxy-manager`   |
| `nginx.image.tag`             | Docker image tag for Nginx Proxy Manager.                                  | `latest`                     |
| `nginx.service.type`          | Type of service for Nginx (e.g., LoadBalancer, ClusterIP, NodePort).       | `LoadBalancer`               |
| `nginx.service.externalIPs`   | External IPs for the Nginx service. Leave empty to skip.                   | `[]`                         |
| `nginx.service.ports.http`    | Port for HTTP traffic.                                                     | `80`                         |
| `nginx.service.ports.https`   | Port for HTTPS traffic.                                                    | `443`                        |
| `nginx.service.ports.webui`   | Port for the Nginx Proxy Manager web interface.                            | `81`                         |
| **Persistent Storage for Nginx** |                                                                        |                              |
| `nginxPVC.accessMode`         | Access mode for the persistent volume claim (PVC).                          | `ReadWriteOnce`              |
| `nginxPVC.storage`            | Amount of storage for Nginx data.                                          | `5Gi`                        |
| **MariaDB Configuration**     |                                                                            |                              |
| `mariadb.replicas`            | Number of replicas for MariaDB.                                            | `1`                          |
| `mariadb.image.repository`    | Docker image repository for MariaDB.                                       | `jc21/mariadb-aria`          |
| `mariadb.image.tag`           | Docker image tag for MariaDB.                                              | `latest`                     |
| `mariadb.env.rootPassword`    | Root password for the MariaDB database.                                    | `root_pass_changeme`         |
| `mariadb.env.database`        | Name of the database created for Nginx Proxy Manager to use.               | `proxy-manager`              |
| `mariadb.env.user`            | Username for the MariaDB user account.                                     | `proxy_manager_user`         |
| `mariadb.env.password`        | Password for the MariaDB user account.                                     | `user_pass_changeme`         |
| `mariadb.service.type`        | Type of service for MariaDB (e.g., ClusterIP, LoadBalancer, NodePort).     | `ClusterIP`                  |
| **Persistent Storage for MariaDB** |                                                                       |                              |
| `mariadbPVC.accessMode`       | Access mode for the MariaDB PVC.                                           | `ReadWriteOnce`              |
| `mariadbPVC.storage`          | Amount of storage for MariaDB data.                                        | `1Gi`                        |
| **Persistent Storage for Let's Encrypt** |                                                               |                              |
| `letsencryptPVC.accessMode`   | Access mode for the Let's Encrypt certificates PVC.                        | `ReadWriteOnce`              |
| `letsencryptPVC.storage`      | Amount of storage for Let's Encrypt certificates.                          | `1Gi`                        |



### Step 3: Install the Chart

Once you've customized the `values.yaml` file, you can install the chart using the following command:

```bash
helm install my-release nginxproxymanager/nginxproxymanager -f values.yaml
```

This will install the chart with the custom values you've specified.

### Step 4: Accessing Nginx Proxy Manager

After the Helm chart is installed, you can access the Nginx Proxy Manager web UI using the service that is created. If you used the default settings (service type: `LoadBalancer`), you can check the external IP address with the following command:

```bash
kubectl get svc nginx-proxy-manager
```

If you are using a `NodePort` or `ClusterIP` service, access the UI based on the port configuration.

The default credentials for logging into the web UI are:
- **Username**: `admin@example.com`
- **Password**: `changeme`

Make sure to change these default credentials after your first login for security.

### Step 5: Upgrading the Chart (if needed)

To upgrade your installation to a newer version of the chart, use the following command:

```bash
helm upgrade my-release nginxproxymanager/nginxproxymanager -f values.yaml
```

### Additional Configuration

You can further customize your installation by modifying the other sections of the `values.yaml` file, such as:

- Configuring a different `image.tag` for Nginx Proxy Manager or MariaDB.
- Changing the Kubernetes service type (`ClusterIP`, `NodePort`, `LoadBalancer`).
- Adjusting storage sizes for the PVCs.

For more information on configuring persistent storage and volumes, refer to the Kubernetes documentation.

### Uninstalling the Chart

If you want to uninstall the Nginx Proxy Manager deployment, you can do so using the following command:

```bash
helm uninstall my-release
```

This will remove the release and its associated resources from your Kubernetes cluster.

---

Happy deploying! If you encounter any issues, feel free to open an issue in the GitHub repository for further support.
