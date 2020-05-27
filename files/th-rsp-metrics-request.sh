#!/bin/bash

#Rquest RSP metrics
sleep 0.1
curl -s --noproxy 127.0.0.1 -k -u "admin:atlas" https://127.0.0.1:32080/monitoring/streamprocessor/metrics > /opt/th_kafka_rsp_metrics.json