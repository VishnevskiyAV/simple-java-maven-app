def mvn
pipeline {
    agent { label 'master' }
        tools {
            maven 'MAVEN'
            jdk 'JAVA'
        }

    stages {
        stage ('Maven Build') {
            steps {
                script {
                        mvn= tool (name: 'MAVEN', type: 'maven') + '/bin/mvn'
                    }
                        sh "${mvn} clean install"
                }
            }
        stage('Build Docker Image'){
            steps{
                sh 'docker build -t vishnevskiyav/java-maven-app:$BUILD_NUMBER .'
            }
        }
        stage('Docker Container Artifactory'){
            steps{
                withCredentials([usernameColonPassword(credentialsId: 'docker-pass', variable: 'DOCKER_PASS')]) {
                sh 'docker push vishnevskiyav/java-maven-app:$BUILD_NUMBER'
                //sh 'docker run -d -p 8050:8050 --name JavaMavenApp vishnevskiyav/java-maven-app:$BUILD_NUMBER'
            }
        }
    }  

  }
post {
    always {
	    sh 'echo "The pipeline work fine"'
    }
    failure {
	    sh 'echo "The pipeline does not work"'
    }
  }
}