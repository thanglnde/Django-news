pipeline {
    agent {
        docker {
            image 'python:3.9'
            args '-v $HOME/.cache/pip:/root/.cache/pip'
        }
    }
    environment {
        DB_HOST = 'db'
        DB_PORT = '5432'
        DB_NAME = 'mydb'
        DB_USER = 'myuser'
        DB_PASSWORD = 'mypassword'
    }
    stages {
        stage('Build'){
            step {
                sh 'pip install pipenv'
                sh 'pipenv install --dev'
            }
        }
        stage('Test'){
            step {
                sh 'pipenv run pytest'
            }
        }
        stage('Build Docker Image'){
            step {
                script {
                    docker.build('myapp:${env.BUILD_NUMBER}')
                }
            }
        }
        stage('Deploy'){
            step {
                script {
                    docker.withRegistry('') {
                        docker.image('').push()
                    }
                }
            }
        }
        stage('Run') {
            step {
                script {
                    docker.withRun("-p 8000:8000 --name myapp --link db:db -e DB_HOST=$DB_HOST -e DB_PORT=$DB_PORT -e DB_NAME=$DB_NAME -e DB_USER=$DB_USER -e DB_PASSWORD=$DB_PASSWORD myapp:${env.BUILD_NUMBER}") {
                        sh 'pipenv run python manage.py migrate'
                        sh 'pipenv run python manage.py runserver 0.0.0.0:8000'
                    }
                }
            }
        }
    }
}