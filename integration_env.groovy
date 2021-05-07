def setDescription() {
    def item = Jenkins.instance.getItemByFullName(env.JOB_NAME)
    item.setDescription("<h5><span style=\"color:#138D75\">This jobs calls the ST_Telegraf_Arcsight_TH_Cluster job to automatically install telegraf on the integration envrinments</span></h5>")
    item.save()
}
setDescription()

pipeline {

	agent { label 'ansible' }
	options {
        //retry(6)
		ansiColor('xterm')
		// ansiColor('vga')
		// ansiColor('css')
		// ansiColor('gnome-terminal')
		
		buildDiscarder(logRotator(daysToKeepStr: '7'))
	}
  
    parameters {
        choice(
		name: 'Cluster',
		choices: ['Integration_ENV_1','Integration_ENV_2'],
		)
        password(
        name: 'Host_Password',
        defaultValue: 'arst@dm1n'
        )
    }
            	
    stages {

        stage("Sleep for Update") {
			steps {
				echo "Sleeping for 10 secs to give me time to get the changes and then stop the job"
                sleep 10
			}
		}

        stage('Installing Telegraf on ENV 1') {
            when {
                expression { params.Cluster == 'Integration_ENV_1' }
            }	
            steps {
                echo "Installing Telegraf on ENV 1"
                build job: 'ST_Telegraf_Arcsight_TH_Cluster',
                    parameters:
                        [
                            string(name: 'TH_Version', value: '3.5'),
                            string(name: 'Master', value: '15.214.141.246'),
                            string(name: 'Workers', value: '15.214.141.212,15.214.141.213,15.214.141.214')
                            string(name: 'InfluxDB', value: '15.214.137.76')
                            string(name: 'Database	', value: 'reconMetrics')
						]
            }
        }

        stage('Installing Telegraf on ENV 2') {
            when {
                expression { params.Cluster == 'Integration_ENV_2' }
            }	
            steps {
                echo "Installing Telegraf on ENV 2"
                build job: 'ST_Telegraf_Arcsight_TH_Cluster',
                    parameters:
                        [
                            string(name: 'TH_Version', value: '3.5'),
                            string(name: 'Master', value: '15.214.141.201'),
                            string(name: 'Workers', value: '15.214.141.202,15.214.141.204,15.214.141.205')
                            string(name: 'InfluxDB', value: '15.214.137.76')
                            string(name: 'Database	', value: 'reconMetrics')
						]
            }
        }
		
    }
  
    post {
        always {
            echo 'Cleaning up the workspace'
            deleteDir()
        }
    }
}
