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

    stage('Dockerdind Build & Push Image') {
      steps {
        container('tomcat') {
          script {
            sh '''
            yum update -y &&
            yum install -y yum-utils &&
            yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &&
            yum update -y &&
            yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            '''
            sh 'docker run hello-world'
          }
        }
      }
    }

    stage('Deploy App to Kubernetes') {     
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'mykubeconfig', variable: 'KUBECONFIG')]) {
            sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" myweb.yaml'
            sh 'kubectl apply -f myweb.yaml'
          }
        }
      }
    }
  
  }
}
