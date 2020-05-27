#!/bin/bash

#This command should be run on each node where the target topic is present, below the command will give the total space usage for all the topic logs with the name th-cef, th-arcsight-avro and th-binary_esm:
du --total /opt/arcsight/k8s-hostpath-volume/th/kafka/th-cef-[0-9]/*.log | tail -1 | awk '{print "th-cef_Topic_Size="$1}'
du --total /opt/arcsight/k8s-hostpath-volume/th/kafka/th-arcsight-avro-[0-9]/*.log | tail -1 | awk '{print "th-arcsight-avro_Topic_Size="$1}'
du --total /opt/arcsight/k8s-hostpath-volume/th/kafka/th-binary_esm-[0-9]/*.log | tail -1 | awk '{print "th-binary_esm_Topic_Size="$1}'