#! /usr/bin/env bash

du --total /opt/arcsight/k8s-hostpath-volume/th/kafka/th-cef-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef Partition_Size="$1}'
du --total /opt/arcsight/k8s-hostpath-volume/th/kafka/th-arcsight-avro-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-arcsight-avro Partition_Size="$1}'
du --total /opt/arcsight/k8s-hostpath-volume/th/kafka/th-binary_esm-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-binary_esm Partition_Size="$1}'

# For used-defined topics, the name of the topic must be passed in the directory and the tag field as well, e.g
#du --total /opt/arcsight/k8s-hostpath-volume/th/kafka/JMETER-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=JMETER Partition_Size="$1}'