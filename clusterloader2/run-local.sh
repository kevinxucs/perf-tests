#!/bin/bash

KUBE_SSH_USER=root \
ETCD_CERTIFICATE=/etc/kubernetes/pki/etcd/server.crt \
ETCD_KEY=/etc/kubernetes/pki/etcd/server.key \
    go run cmd/clusterloader.go \
    --kubeconfig=$HOME/.kube/config \
    --testconfig=testing/load/config.yaml \
    --provider=local \
    --nodes=3 \
    --report-dir=report_load_local-cluster \
    --masterip=k8s-cp-01.intern.kevxu.net,k8s-cp-02.intern.kevxu.net,k8s-cp-03.intern.kevxu.net \
    --etcdip=k8s-etcd-01.intern.kevxu.net,k8s-etcd-02.intern.kevxu.net,k8s-etcd-03.intern.kevxu.net \
    --etcd-certificate=/etc/kubernetes/pki/apiserver-etcd-client.crt \
    --etcd-key=/etc/kubernetes/pki/apiserver-etcd-client.key
