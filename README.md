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

#### Using Kubernetes Secrets for MariaDB Credentials

By default, the chart will create a Kubernetes Secret to store the MariaDB root password, user, and user password.  
If you want to use your own existing secret, set `mariadb.existingSecret` to the name of your secret.  
Your secret must contain the following keys:

- `mysql-root-password`
- `mysql-user`
- `mysql-user-password`

Example:

```yaml
mariadb:
  existingSecret: my-mariadb-secret
```

Example Secret manifest:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-mariadb-secret
  namespace: <your-namespace>
type: Opaque
stringData:
  mysql-root-password: myRootPassword
  mysql-user: myUser
  mysql-user-password: myUserPassword
```

If `mariadb.existingSecret` is not set, the chart will create a secret named `<release-name>-mariadb-secret` using the values from `mariadb.env.rootPassword`, `mariadb.env.user`, and `mariadb.env.password`.

# Helm Values for Nginx Proxy Manager Deployment

The following table outlines the configuration options available for deploying Nginx Proxy Manager using Helm. You can customize these values to fit your requirements.

| **Parameter**                            | **Description**                                  | **Default Value**          |
| ---------------------------------------- | ------------------------------------------------ | -------------------------- |
| `namespaceOverride`                      | Namespace for all resources.                     | `""`                       |
| **Nginx Configuration**                  |                                                  |                            |
| `nginx.replicas`                         | Number of Nginx Proxy Manager pods.              | `1`                        |
| `nginx.image.repository`                 | Nginx Proxy Manager image repository.            | `jc21/nginx-proxy-manager` |
| `nginx.image.tag`                        | Nginx Proxy Manager image tag.                   | `latest`                   |
| `nginx.service.type`                     | Service type for Nginx Proxy Manager.            | `LoadBalancer`             |
| `nginx.service.externalIPs`              | List of external IPs for the Nginx service.      | `[]`                       |
| `nginx.service.ports.http`               | HTTP port.                                       | `80`                       |
| `nginx.service.ports.https`              | HTTPS port.                                      | `443`                      |
| `nginx.service.ports.webui`              | Web UI port.                                     | `81`                       |
| **Persistent Storage for Nginx**         |                                                  |                            |
| `nginxPVC.accessMode`                    | Access mode for Nginx PVC.                       | `ReadWriteOnce`            |
| `nginxPVC.storage`                       | Storage size for Nginx PVC.                      | `5Gi`                      |
| `nginxPVC.storageClassName`              | Storage class for Nginx PVC.                     | `""`                       |
| **MariaDB Configuration**                |                                                  |                            |
| `mariadb.replicas`                       | Number of MariaDB pods.                          | `1`                        |
| `mariadb.image.repository`               | MariaDB image repository.                        | `jc21/mariadb-aria`        |
| `mariadb.image.tag`                      | MariaDB image tag.                               | `latest`                   |
| `mariadb.env.rootPassword`               | MariaDB root password.                           | `root_pass_changeme`       |
| `mariadb.env.database`                   | MariaDB database name.                           | `proxy-manager`            |
| `mariadb.env.user`                       | MariaDB username.                                | `proxy_manager_user`       |
| `mariadb.env.password`                   | MariaDB user password.                           | `user_pass_changeme`       |
| `mariadb.existingSecret`                 | Name of existing secret for MariaDB credentials. | `""`                       |
| `mariadb.service.type`                   | Service type for MariaDB.                        | `ClusterIP`                |
| **Persistent Storage for MariaDB**       |                                                  |                            |
| `mariadbPVC.accessMode`                  | Access mode for MariaDB PVC.                     | `ReadWriteOnce`            |
| `mariadbPVC.storage`                     | Storage size for MariaDB PVC.                    | `1Gi`                      |
| `mariadbPVC.storageClassName`            | Storage class for MariaDB PVC.                   | `""`                       |
| **Persistent Storage for Let's Encrypt** |                                                  |                            |
| `letsencryptPVC.accessMode`              | Access mode for Let's Encrypt PVC.               | `ReadWriteOnce`            |
| `letsencryptPVC.storage`                 | Storage size for Let's Encrypt PVC.              | `1Gi`                      |
| `letsencryptPVC.storageClassName`        | Storage class for Let's Encrypt PVC.             | `""`                       |

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
