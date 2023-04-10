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
                    sh "DOCKER_BUILDKIT=1 docker buildx build --progress=plain --no-cache -t uday1kiran/testimage:latest . --push --output type=docker"
                    sh 'docker image ls'
                    sh 'DOCKER_BUILDKIT=1  docker buildx image ls'
                }
          }
        }
      }
    }
  
  }
}
