pipeline {
    agent any
    // agent {
    //     node{
    //         label "ansible"
    //     }
        
    // }

    environment {
        DOCKER_IMAGE = "devopssteps/laravel-app"
        K8S_NAMESPACE = "default"
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credential')

    }

    stages {
        //clone git repo
        stage('Checkout') {
            steps {
                deleteDir()
                checkout scm
            }
        }

        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/devopssteps/project-5-laravel-docker-k8s-ansible.git'
            }
        }
        // Build docker image
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }

        stage('Login to dockerhub and push the image') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
            }
        }
        
        
        // stage('Push to DockerHub') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
        //             sh """
        //                 echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
        //                 docker push $DOCKER_IMAGE:$BUILD_NUMBER
        //             """
        //         }
        //     }
        // }

        // stage('Deploy to K8s via Ansible') {
        //     steps {
        //         sh 'ansible-playbook ansible/deploy.yml --extra-vars "image=$DOCKER_IMAGE:$BUILD_NUMBER"'
        //     }
        // }
    }
}
