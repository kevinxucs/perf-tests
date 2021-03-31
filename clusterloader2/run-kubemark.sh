#!/bin/bash

KUBE_SSH_USER=root \
ETCD_CERTIFICATE=/etc/kubernetes/pki/etcd/server.crt \
ETCD_KEY=/etc/kubernetes/pki/etcd/server.key \
    go run cmd/clusterloader.go \
    -v=4 \
    --kubeconfig=$HOME/.kube/km-config \
    --testconfig=testing/load/config.yaml \
    --provider=kubemark \
    --nodes=60 \
    --report-dir=report_load_kubemark-cluster \
    --masterip=k8s-km-01.intern.kevxu.net \
    --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.key \
    --testoverrides=./testing/overrides/stateless_only.yaml
