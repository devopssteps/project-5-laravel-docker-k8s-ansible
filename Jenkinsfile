pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "rajivsiddiqui/laravel-app"
        K8S_NAMESPACE = "default"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/yourusername/laravel-docker-k8s.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE:$BUILD_NUMBER
                    """
                }
            }
        }

        stage('Deploy to K8s via Ansible') {
            steps {
                sh 'ansible-playbook ansible/deploy.yml --extra-vars "image=$DOCKER_IMAGE:$BUILD_NUMBER"'
            }
        }
    }
}
