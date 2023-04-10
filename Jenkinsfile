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
            #sleep 1m
            yum install -y git
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
            '''
            withCredentials([usernamePassword(credentialsId: 'testimage', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                    #sh 'docker build -t myimage:latest .'
                    sh "DOCKER_BUILDKIT=1 docker buildx build --progress=plain --no-cache -t uday1kiran/testimage:latest . --push"
                    #sh 'docker tag myimage:latest uday1kiran/testimage:latest'
                    #sh 'docker push uday1kiran/testimage:latest'
                }
            #docker image ls
            #DOCKER_BUILDKIT=1 docker buildx build --progress=plain --no-cache -t uday1kiran/testimage:latest . --push
            ##docker tag testimage:latest newimage:latest
            #docker buildx image ls
            #docker buildx tag testimage:latest newimage:latest
            #'''
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
