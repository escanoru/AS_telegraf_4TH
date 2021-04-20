#! /usr/bin/env bash

# Get the Metrics from "kubectl get po -A -o wide"
kubectl get po -A -o wide | awk '{print "exec_K8s_get_pod,NAMESPACE="$1 ",POD_NAME="$2 ",READY="$3 ",STATUS="$4 ",AGE="$6 ",IP="$7 ",NODE="$8 " RESTARTS="$5}' | tail -n +2