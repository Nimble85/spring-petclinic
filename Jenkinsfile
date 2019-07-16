node  {
    def server = Artifactory.server 'ART'
    def rtMaven = Artifactory.newMavenBuild()
    def buildInfo

/*
    stage ('Remote all old images') {
        bash '''#!/bin/bash
            "docker stop $(docker ps -a |grep javaproject | awk '{print $1}' | head -1) || docker ps -a"
            "docker rm $(docker ps -a |grep javaproject | awk '{print $1}' | head -1) || docker ps -a"
                 '''
    }
*/  
    stage ('Clone') {
        git url: 'https://github.com/Nimble85/spring-petclinic.git'
    }

    stage ('Artifactory configuration') {
        rtMaven.tool = 'M3' // Tool name from Jenkins configuration
        rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local', server: server
        rtMaven.resolver releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot', server: server
        buildInfo = Artifactory.newBuildInfo()
    }

    stage ('Exec Maven') {
        rtMaven.run pom: 'pom.xml', goals: 'clean install', buildInfo: buildInfo
    }

    stage ('Publish build info') {
        server.publishBuildInfo buildInfo
    }

    stage('Build image') {
        app = docker.build("javaproject:${env.BUILD_ID}")
    } 
    /*
    agent {
        docker { image 'javaproject:${env.BUILD_ID}' }
    }
*/
    stage('Docker container RUN'){
        sh "docker run -d --name javaproject -p 8085:8080 javaproject:${env.BUILD_ID}"
    }
    

    stage('Sleep'){
        sh "sleep 30s"
    }
    
    stage('Docker container TEST'){
        sh "curl -I http://localhost:8085/ -v >>  curl || cat curl"
    }
/*    
    stage('Clean'){
        sh "docker rmi javaproject:${env.BUILD_ID} "
    }*/
}

