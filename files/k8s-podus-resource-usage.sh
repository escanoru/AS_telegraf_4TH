#! /usr/bin/env bash

# Kafka and C2AV pod resources usage (Milicores request and Memory usage)
kubectl top po -n $(kubectl get pod --all-namespaces | grep -Eio "arcsight-installer-([0–9a-z|a-z0-9]+)" | head -1) | grep -E "th-kafka-[0-9+]|th-c2av-processor-[0-9+]" | awk '{ gsub("m","",$2) ; gsub("Mi","",$3) ; print "exec_K8s_Pod_Resources_Usage,POD="$1" CPU_Mili_Cores_Request="$2",MEM_Usage="$3}'