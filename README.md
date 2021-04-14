Telegraf TH 3.4/3.5 Cluster Kafka Manager Metrics
=========================================
Starting on TH 3.2 ports changed from 39XXX to 32XXX, this role takes care of this change.

This role is the same as https://github.houston.softwaregrp.net/alexander-eze-ruiz-mora/ansible_tegraf_th_cluster_kafka_manager_metrics but it already includes the needed packages for completing the installation, this speeds up things as there is no need to download packages from the internet:

Ansible role to install Telegraf on a TH cluster, both Master and Workers to get metrics from the Kafka Manager pod running on one of the master nodes; This role will also scrape the size of the following topics on each worker node:
1. th-cef
2. th-arcsight-avro
3. th-binary_esm
4. mf-event-avro-esmfiltered
5. mf-event-avro-enriched

The Grafana dashboard is provided on the "Grafana_Dashboard" folder.

Requirements
------------
1. CentOS-7/RHEL-7
2. Ansible 2.9.2+

Role Variables
--------------
Two variables are used in this role, the user should fill each variable with its respective value
1. "influxdb_ip"
2. "database_name"

Dependencies
------------
None

Instructions
---------------------------
1. Download this project to your ansible instance
2. Open the telegraf_th_cluster_kafka_manager_metrics.yml file and fill the "influxdb_ip" and "database_name".
3. Open the ```th_cluster_inventory.ini``` file and add 1 master(only 1 master is needed) and the workers running on your TH cluster
4. Run the playbook by running the command below:
```sh
time sudo ansible-playbook -i th_cluster_inventory.ini main.yml
```

License
-------
BSD

Author Information
------------------
Arcsight System-Test team
