pipeline {
    // agent
    agent{
        node {
            label 'vps_51'
            customWorkspace "workspace/${env.BRANCH_NAME}/src/github.com/aditya37/reverse-proxy/"
        }
    }
    // global env
    environment {
        // telegram group id
        NOTIFDEPLOY = -522638644
    }
    // pipeline stage....
    stages {
        stage("Checkout"){
            when {
                anyOf { 
                    branch 'main'; 
                    branch 'develop'; 
                    branch 'staging';
                    branch 'test'
                }
            }
            steps {
                echo 'Checking out from git'
                checkout scm
                script {
                    env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B ${GIT_COMMIT}', returnStdout:true).trim()
                }
            }
        }
        // stage copy upstream
        stage("Configuring Service Upstream") {
            echo 'configure upstream'
        }
        stage("Configuring Service URL") {
            echo 'Configuring Service URL'
        }
    }
}