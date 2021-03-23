#! /usr/bin/env bash

# Here I preffer to cd fisrt because after the +100 partitions du complians there are too many arguments, it's better to enter the directory and then retrieve the size of the partitions, you could do cd only once and then chain(;) the rest of the commands, it will be 1 line but it is a quite cumbersome reading through that, beside the execution time remains below 1 second so it's better to have a clear view of what we are excecuting:
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-cef-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef Partition_Size="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-cef-[0-9][0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef Partition_Size_II="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-cef-[0-9][0-9][0-4]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef Partition_Size_III="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-cef-[0-9][0-9][5-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef Partition_Size_IV="$1}'

cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-cef-other-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef-other Partition_Size="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-cef-other-[0-9][0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef-other Partition_Size_II="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-cef-other-[0-9][0-9][0-4]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef-other Partition_Size_III="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-cef-other-[0-9][0-9][5-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-cef-other Partition_Size_IV="$1}'

cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-arcsight-avro-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-arcsight-avro Partition_Size="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-arcsight-avro-[0-9][0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-arcsight-avro Partition_Size_II="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-arcsight-avro-[0-9][0-9][0-4]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-arcsight-avro Partition_Size_III="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-arcsight-avro-[0-9][0-9][5-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-arcsight-avro Partition_Size_IV="$1}'

cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-avro-enriched-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-avro-enriched Partition_Size="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-avro-enriched-[0-9][0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-avro-enriched Partition_Size_II="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-avro-enriched-[0-9][0-9][0-4]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-avro-enriched Partition_Size_III="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-avro-enriched-[0-9][0-9][5-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-avro-enriched Partition_Size_IV="$1}'

cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-avro-esmfiltered-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-avro-esmfiltered Partition_Size="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-avro-esmfiltered-[0-9][0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-avro-esmfiltered Partition_Size_II="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-avro-esmfiltered-[0-9][0-9][0-4]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-avro-esmfiltered Partition_Size_III="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-avro-esmfiltered-[0-9][0-9][5-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-avro-esmfiltered Partition_Size_IV="$1}'

cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-cef-esmfiltered-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-cef-esmfiltered Partition_Size="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-cef-esmfiltered-[0-9][0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-cef-esmfiltered Partition_Size_II="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-cef-esmfiltered-[0-9][0-9][0-4]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-cef-esmfiltered Partition_Size_III="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total mf-event-cef-esmfiltered-[0-9][0-9][5-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=mf-event-cef-esmfiltered Partition_Size_IV="$1}'

cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-binary_esm-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-binary_esm Partition_Size="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-binary_esm-[0-9][0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-binary_esm Partition_Size_II="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-binary_esm-[0-9][0-9][0-4]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-binary_esm Partition_Size_III="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-binary_esm-[0-9][0-9][5-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-binary_esm Partition_Size_IV="$1}'

cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-syslog-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-syslog Partition_Size="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-syslog-[0-9][0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-syslog Partition_Size_II="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-syslog-[0-9][0-9][0-4]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-syslog Partition_Size_III="$1}'
cd /opt/arcsight/k8s-hostpath-volume/th/kafka/ && du -sb --total th-syslog-[0-9][0-9][5-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=th-syslog Partition_Size_IV="$1}'

# For used-defined topics, the name of the topic must be passed in the directory and the tag field as well, e.g
#du -sb --total /opt/arcsight/k8s-hostpath-volume/th/kafka/JMETER-[0-9]/*.log | tail -1 | awk '{print "exec_Kafka_Topic_Size_Metrics,attribute=none,Topic=JMETER Partition_Size="$1}'





