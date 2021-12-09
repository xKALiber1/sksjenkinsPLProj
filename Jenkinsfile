pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    environment {
        CREDENTIALS=credentials('Docker')
        AWS=credentials('AWS')
    }
    stages {
        stage('Build image') {
            steps {
                sh 'mvn clean install'
                sh 'docker build -t kvaughn2021/maven:latest .'
            }
        }
        stage('Login') {
			steps {
withCredentials([usernamePassword(credentialsId: 'Docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
			}
		}
	}
        stage('push image') {
            steps {
                sh 'docker push kvaughn2021/maven:latest'
            }
        }
        stage ('K8S Deploy') {
            steps {
                withKubeConfig([credentialsId: 'K8s']) {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl rollout restart deployment maven-app-deploy'
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
