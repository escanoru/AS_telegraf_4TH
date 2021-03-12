#! /usr/bin/env bash

# The folowing command collects the cpu mili cores and ram PODS metrics from the arcsight-*-* NS
kubectl top po -n $(kubectl get pod --all-namespaces | grep -Eio "arcsight-installer-([0–9a-z|a-z0-9]+)" | head -1) | grep -E "" | awk '{ gsub("m","",$2) ; gsub("Mi","",$3) ; print "exec_K8s_Pod_Resources_Usage,POD="$1" CPU_Mili_Cores_Request="$2",MEM_Usage="$3}' | tail -n +2