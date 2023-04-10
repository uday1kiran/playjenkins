pipeline {

  options {
    ansiColor('xterm')
  }

  agent {
    kubernetes {
      yamlFile 'builder.yaml'
    }
  }
  
  environment {
    BRANCH_NAME = "${GIT_BRANCH.replace('origin/','')}"
    shortCommitId = "${GIT_COMMIT}".take(7)
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
                    sh "DOCKER_BUILDKIT=1 docker buildx build --progress=plain --no-cache -t uday1kiran/testimage:${env.BRANCH_NAME} . --output type=docker" //--push skipped here
                    sh 'docker image ls'
                    sh 'docker tag uday1kiran/testimage:${env.BRANCH_NAME}  uday1kiran/testimage:${env.BRANCH_NAME}-${env.shortCommitId}'
                    sh 'docker push uday1kiran/testimage:${env.BRANCH_NAME}-${env.shortCommitId}'
              /*script{
              def shortCommitId = "${env.GIT_COMMIT}".take(7)
               sh 'docker tag uday1kiran/testimage:${env.GIT_BRANCH} uday1kiran/testimage:${env.GIT_BRANCH}-${shortCommitId}'
               sh 'docker push uday1kiran/testimage:${env.GIT_BRANCH}-${shortCommitId}'               
              }*/
                   
              //https://stackoverflow.com/questions/64403659/docker-buildx-image-not-showing-in-docker-image-ls
                }
          }
        }
      }
    }
  
  }
}
