FROM jenkins/jenkins:lts

USER root

# Install custom plugins
RUN jenkins-plugin-cli --plugins "snyk-security-scanner:2.12.1 file-operations:1.11 branch-api:2.5.6 pipeline-build-step:2.13 workflow-support:3.8 aws-credentials:1.28 subversion:2.13.1 github-branch-source:2.7.1 publish-over-ftp:1.15 cloudbees-folder:6.740.ve4f4ffa_dea_54"

# Set environment variables
# ENV <ENV_VARIABLE_1> <VALUE>
# ENV <ENV_VARIABLE_2> <VALUE>

USER jenkins
