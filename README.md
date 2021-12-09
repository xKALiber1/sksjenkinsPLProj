# sksjenkinsPLProj

## What is this Repo For
  Repo for final skillstorm jenkins pipeline project
# Create VM in AWS

## run setup.sh script once VM is provisioned

    create a file called setup.sh in the current directory
    copy contents of jenkins.sh in the repository to that file and save it
    
    Set the execution bit for the bash script
        chmod +x setup.sh
    
    Run the script (initial jenkins password will be the final output)
        sudo ./setup.sh

## Run the following commands

    sudo usermod -aG docker $USER
    sudo usermod -aG docker jenkins
    export PATH=/opt/maven/bin:$PATH
    sudo service jenkins restart
    cd Pipeline
    mkdir ~/.kube
    cp config.yaml ~/.kube

# restart terminal!!

___


# Configure Jenkins

## Login to jenkins and create account

    sudo cat /var/lib/jenkins/secrets/initialAdminPassword

## Set up jenkins tools

    install suggested plugins
    install plugins
        1. maven integration
        3. docker
        4. docker pipeline
        5. kubernetes
        6. kubernetes cli
        7. blue ocean
        8. AWS credentials

    set up global tools
        1. jdk: 
           1. Name: JAVA_HOME
           2. JAVA_HOME: /usr/lib/jvm/java-11-openjdk-amd64/
        2. Git
           1. Name: Git
           2. path to git: /usr/bin/git
        3. Maven
           1. Name: Maven
           2. MAVEN_HOME: /opt/maven

## set-up credentials in jenkins

    add docker creds
    add aws creds

___

# Run first pipeline

    1. create pipeline in jenkins
       1. add in your github repository with Jenkinsfile in pipeline config
    2. initialize github webhook 
       1. http://<jenkins_public_ip>:8080/github-webhook/
    3. Set up docker credentials using docker API token from dockerhub

run pipeline
___
# Set up EKS Clusters and deploy to production

## Set up AWS (installed as part of setup script if you used that)

    Ensure AWSCLI is installed (sudo apt install awscli)
    add global credentials (aws configure)
        add in your access key and secret access key

## install kubectl (installed as part of setup script if you used that)

    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    
## install EKSCTL (installed as part of setup script if you used that)

    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

    sudo mv /tmp/eksctl /usr/local/bin

## Set up EKS and Jenkins to finalize your pipeline

    Use the clusterconfig.yaml file to configure your EKS cluster 

    run the following command:
        
        eksctl create cluster --config-file clusterconfig.yaml (will take about 20 minutes or more)
        
        once this is complete, the output will tell you where your config file is located at
    
    once this is up and running you will need to create a cluster config secret in jenkins
        1. make a copy of your config file and put it in a location where you can upload it in jenkins
        2. go to credentials and create a new global credential and select secret file
        3. upload your config file in the secret file and give it a name.  You will reference this in your Jenkinsfile

## Finalize your Jenkinsfile with the deployment to kubernetes

