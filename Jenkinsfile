pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t thangdz233/jenkinsdjango:latest .'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    sh 'docker push thangdz233/jenkinsdjango:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker run -p 8000:8000 -d thangdz233/jenkinsdjango:latest'
            }
        }
    }
}
