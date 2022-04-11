pipeline{
    agent any
    
    tools{
         maven 'Jenkins-worker-maven'
         jdk 'Jenkins-jdk'
    }
    
    stages{
        
        stage('pulling the source code from scm'){
         steps{
          git branch: 'master',
          url: 'https://github.com/Saleem313/medilab-app-monolith-docker-compose.git'
         }
        }
        
        stage('building the source code'){
         steps{
             echo 'project build started'
             sh 'mvn clean package -DskipTests'
         }
        }
        
        stage('building the docker image'){
         steps{
             echo 'docker image building...'
             sshagent(credentials :['Ansibleadmin-creds']){
               echo 'connected to remote host'
               sh 'scp  Dockerfile ansibleadmin@172.31.43.66:/home/ansibleadmin'
               sh 'scp docker-img-build-playbook.yml ansibleadmin@172.31.43.66:/home/ansibleadmin'
               sh 'scp target/medilab-morning-preclinic-war-0.0.1-SNAPSHOT.war ansibleadmin@172.31.43.66:/home/ansibleadmin/target'
               sh '''
                  ssh -tt ansibleadmin@172.31.43.66 << EOF
                       ansible dockerserver -m copy -a  "src=/home/ansibleadmin/Dockerfile dest=."
                       ansible dockerserver -m copy -a  "src=/home/ansibleadmin/target dest=."
                       rm /home/ansibleadmin/target/*
                       ansible-playbook  docker-img-build-playbook.yml
                       exit
                       EOF
               '''
             }
             
         }
        }
        
         stage('trigger db deployment pipeline'){
            steps{
                build job : 'medilab-db-deployment-pipeline'
            }
        }
    }
}