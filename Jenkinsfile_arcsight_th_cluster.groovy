def setDescription() { 
  def item = Jenkins.instance.getItemByFullName(env.JOB_NAME) 
  item.setDescription("<h5 style=\"color:#138D75\">This jobs installs Telegraf with the required parameters to scrape metrics from the kafka-manager pod in a given master node, it also scrapes the topic size of the th-cef, th-arcsight-avro and the th-binary_esm topics from the worker nodes and the master node as well, just in case the master runs as a worker.<br>Dashboard: <a href=\"https://15.214.145.90:8083/d/qe7ltXHMz/kafka-metrics?orgId=5&refresh=10s\">TH Kafka Metrics</a></h5>") 
  item.save()
  }
setDescription()

pipeline {
	// agent any
	agent { label 'ansible' }
	options {
		ansiColor('gnome-terminal')
		buildDiscarder(logRotator(daysToKeepStr: '30'))
		}
  
        	
	parameters {
		choice(
		    name: 'TH_Version',
		    choices: ['3.5', '3.4'],
			description: "3.5 also covers 3.6"
		)
		string(
		name: 'Master', 
		description: '<h5>Only 1 master node ip is needed, even if the cluster has multiple masters only provide 1.</h5>'
		)
		string(
		name: 'Workers', 
		description: '<h5>Worker nodes ip separated by comma, e.g 15.214.x.x<span style=\"color:red\";>, </span>15.214.x.x, 15.214.x.x<span style=\"color:red\">, </span>15.214.x.x</h5>'
		)
		password(
		name: 'Host_Password', 
		defaultValue: 'arst@dm1n', 
		description: '<h5>Host root\'s password. The default password is <span style=\"color:red\">arst@dm1n</span>, you can change it by clicking on \"Change Password\".</h5>'
		)
		string(
		name: 'Interval', 
		defaultValue: '10', 
		description: '<h5>How often(in seconds) the metrics will be scrapped, default is 10 seconds.</h5>'
		)
		string(
		name: 'InfluxDB', 
		defaultValue: '15.214.128.179', 
		description: '<h5>The InfluxDB server ip/hostname where the metrics will be sent. \nIf you don\'t have an InfluxDB instance you can use <span style=\"color:red\">15.214.128.179</span> with the database name <span style=\"color:red\">system_test</span></h5>'
		)
		string(
		name: 'Database', 
		defaultValue: 'system_test', 
		description: '<h5>The data base name where the metrics will be stored. \nIf you don\'t have an InfluxDB instance you can use <span style=\"color:red\">15.214.128.179</span> with the database name <span style=\"color:red\">system_test</span></h5>'
		)
		string(
		name: 'Username', 
		defaultValue: '', 
		description: '<h5>The influxDB username to authenticate before sending metrics to InfluxDB, leave empty if this wasn\'t setup on your influxDB instance</h5>'
		)
		password(
		name: 'Username_Password', 
		defaultValue: '', 
		description: '<h5>The influxDB username\'s password to authenticate before sending metrics to InfluxDB, leave empty if this wasn\'t setup on your influxDB instance</h5>'
		)		
		}
	
            	
  stages {

		stage('Check Ansible Inventory File') {
			steps {
				sh '''
				echo -e "[master]\\n\\n[workers]" >  ${WORKSPACE}/inventory.ini | cat ${WORKSPACE}/inventory.ini
				echo ${Master} | sed \'s/,/\\n/g\' | while read line ; do sed -i \'/\\[master\\]/a \\\'"${line}"\'\' ${WORKSPACE}/inventory.ini ; done
				echo ${Workers} | sed \'s/,/\\n/g\' | while read line ; do sed -i \'/\\[workers\\]/a \\\'"${line}"\'\' ${WORKSPACE}/inventory.ini ; done
				'''
			}
		}

    stage('Ansible Role Task') {
      steps {
        ansiblePlaybook(
        playbook: "${env.WORKSPACE}/th_cluster_main_for_jenkins.yml",
        inventory: "${env.WORKSPACE}/inventory.ini",
        colorized: true,
		extras: '--ssh-extra-args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" -v',
        extraVars: [
		    th_version: "${params.TH_Version}",
			interval: "${params.Interval}",
            influxdb_ip: "${params.InfluxDB}",
            database_name: "${params.Database}",
            ansible_password: [value: '${Host_Password}', hidden: true],
			db_username: '${Username}',
			db_username_pass: '${Username_Password}'		
        ])
	  }	
    }		
		
  }
  
  post {
	  always {
		  echo 'Clenning up the workspace'
		  deleteDir()
	  }
	}
}