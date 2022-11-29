def mvn
pipeline {
    agent any
        tools {
            maven 'MAVEN'
            //jdk 'JAVA'
        }
    environment {     
    DOCKERHUB_CREDENTIALS= credentials('docker-pass')     
    }

    stages {
        stage ('Maven Build') {
            steps {
                script {
                        mvn= tool (name: 'MAVEN', type: 'maven') + '/bin/mvn'
                    }
                        sh "${mvn} -B -DskipTests clean package"
                }
            }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Build Docker Image'){
            steps{
                sh 'docker build -t vishnevskiyav/java-maven-app:$BUILD_NUMBER .'
            }
        }
        stage('Login to Docker Hub') {      	
            steps{                       	
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                		
                sh 'echo Login Completed'      
            }           
        }
        stage('Docker Container Artifactory'){
            steps{
                sh 'docker push vishnevskiyav/java-maven-app:$BUILD_NUMBER'
                sh 'echo Push Image Completed'
                //sh 'docker run -d -p 8050:8050 --name JavaMavenApp vishnevskiyav/java-maven-app:$BUILD_NUMBER'
            }
        }  
  }
post {
    always {
	    sh 'docker logout'
    }
    failure {
	    sh 'echo "The pipeline does not work"'
    }
  }
}