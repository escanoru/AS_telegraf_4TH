Telegraf TH 3.4/3.5 Cluster Kafka Manager Metrics
=========================================

Ansible role to install Telegraf on a TH cluster, both Master and Workers to get metrics from the Kafka Manager pod running on one of the master nodes; This role will also scrape the size of the following topics on each worker node:
1. th-cef
2. th-arcsight-avro
3. th-binary_esm
4. mf-event-avro-esmfiltered
5. mf-event-avro-enriched

Requirements
------------
1. CentOS-7/RHEL-7
2. Ansible 2.9.2+ (Make sure the parameter ```"host_key_checking = False"``` **is uncomment** on the ```/etc/ansible/ansible.cfg```)
3. An InfluxDB with a database (created before running this role) where the metrics collected by telegraf will be stored.

Role Variables
--------------
The following variables are used in this role, the user should fill each variable with its respective value on the ```main_static.yml``` file (or provide them when using ```main_dynamic.yml```) :
1. "th_version"
2. "interval"
3. "influxdb_ip"
4. "database_name"
5. "db_username"
6. "db_username_pass"
7. "proxyk"

Dependencies
------------
None

Instructions
---------------------------
1. Download this project to your ansible instance
2. Open the ```th_cluster_inventory.ini``` file and add 1 master(only 1 master is needed) and the workers running on your TH cluster
3. Open the ```main_static.yml``` file and fill the variables with the apropriate information.
4. Run the playbook by running the command below:
```sh
time sudo ansible-playbook -i th_cluster_inventory.ini main_static.yml -k
```
  Alternatively you can run the following to enter the variables values through command prompt:

```sh
time sudo ansible-playbook -i th_cluster_inventory.ini main_dynamic.yml -k
```

5. Provide the info for each prompt

License
-------
BSD

Author Information
------------------
Arcsight System-Test team
