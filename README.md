# kube-metrics-server-exporter

![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/vfabi/kube-metrics-server-exporter)
![GitHub last commit](https://img.shields.io/github/last-commit/vfabi/kube-metrics-server-exporter)

[![Generic badge](https://img.shields.io/badge/hub.docker.com-vfabi/kube_metrics_server_exporter-<>.svg)](https://hub.docker.com/repository/docker/vfabi/kube-metrics-server-exporter)
![Docker Version](https://img.shields.io/docker/v/vfabi/kube-metrics-server-exporter)
![Docker Pulls](https://img.shields.io/docker/pulls/vfabi/kube-metrics-server-exporter)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/vfabi/kube-metrics-server-exporter)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/vfabi/kube-metrics-server-exporter)

kube-metrics-server-exporter provides cpu and memory metrics for Kubernetes nodes and pods, directly querying the metrics-server API `/apis/metrics.k8s.io/v1beta1/{pods, nodes}`

## Features

### Node metrics

* kube_metrics_server_nodes_mem
	* Provides nodes memory information in kibibytes.
* kube_metrics_server_nodes_cpu
	* Provides nodes CPU information in nanocores.

#### labels

* instance

### Pod metrics

* kube_metrics_server_pods_mem
	* Provides pods/container memory information.
* kube_metrics_server_pods_cpu
	* Provides pods/container memory information.

#### labels

* pod_name
* pod_namespace
* pod_container_name

### API metrics

* kube_metrics_server_response_time
	* Provides API response time in seconds.

## Variables

  * K8S_ENDPOINT
    * Url of API of kubernetes (default kubernetes.default.svc)

  * K8S_TOKEN
    * The authorization token (default ServiceAccount token)

  * K8S_FILEPATH_TOKEN
    * Path of ServiceAccount token file (default /var/run/secrets/kubernetes.io/serviceaccount/token)

  * K8S_CA_CERT_PATH
    * Path of Kubernetes CA certificate (default /var/run/secrets/kubernetes.io/serviceaccount/ca.crt)

  * NAMES_BLACKLIST
    * A list of names from pods, containers or namespaces to exclude from metrics.
  * NAMESPACE_WHITELIST
    * A list of namespace to scrape from this way you can create namespaced rolebinding instead of cluster binding. ( quite useful for larger clusters ) ( default : '' (all namespaces))
  * LABEL_SELECTOR
    * A list of Label Selectors.

## Options

  * --insecure-tls
    * Disables TLS verification of the Kubernetes API Server.  (Not recommended in production)

## Blacklist

If you want, you could blacklist some names of namespaces, pods or containers, you just need to apply this ConfigMap, replacing the example names:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: metrics-server-exporter
  labels:
    k8s-app: metrics-server-exporter
data:
  NAMES_BLACKLIST: kube-proxy,calico-node,kube2iam  # example names
```

## Usage

You will need `K8S_TOKEN` and `K8S_ENDPOINT` to access the api-server.  Use "--insecure-tls" or mount the CA certificate into the container. Kubernetes will provide the CA certificate in a Kubernetes installation.

```sh
docker run -p 8000:8000 -e "K8S_ENDPOINT=${K8S_ENDPOINT}" -e "K8S_TOKEN=${K8S_TOKEN}" vivareal/metrics-server-exporter --insecure-tls
```

## Build

```sh
docker buildx build --push --platform=linux/amd64,linux/arm64 -t vfabi/kube-metrics-server-exporter:latest -f Dockerfile .
```

## Deploy

Use helm chart from `deploy/helm` folder.

```sh
helm install --name=metrics-server-exporter --namespace kube-system deploy/helm
```

##  Docker

[![Generic badge](https://img.shields.io/badge/hub.docker.com-vfabi/kube_metrics_server_exporter-<>.svg)](https://hub.docker.com/repository/docker/vfabi/kube-metrics-server-exporter)  
[![Generic badge](https://img.shields.io/badge/quay.io-vfabi/kube_metrics_server_exporter-<>.svg)](https://quay.io/vfabi/kube-metrics-server-exporter)
