pipeline {

  options {
    ansiColor('xterm')
  }

  agent {
    kubernetes {
      yamlFile 'builder.yaml'
    }
  }

  stages {

    stage('Dockerdind Check') {
      steps {
        container('tomcat') {
          script {
            /*sh '''
            yum update -y &&
            yum install -y yum-utils &&
            yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &&
            yum update -y &&
            yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            '''*/
            sh '''
            sleep 1m
            docker image ls &&
            docker container ps -a &&
            docker run hello-world &&
            docker container ps &&
            whereis yum && whereis apt && whereis apk && whereis pacman &&
            aws --version &&
            java -version &&
            whereis aws &&
            whereis java
            '''
          }
        }
      }
    }
    
    stage('Dockerdind Build and Push') {
      steps {
        container('tomcat') {
          script {
            sh '''
            ls -la
            ls -lRt
            docker image ls
            DOCKER_BUILDKIT=1 docker build -t testimage:latest .
            docker image ls
            '''
          }
        }
      }
    }

    /*stage('Deploy App to Kubernetes') {     
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
            sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" myweb.yaml'
            sh 'kubectl apply -f myweb.yaml'
          }
        }
      }
    }*/
  
  }
}
