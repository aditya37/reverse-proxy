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
        // stage copy upstream & Service URL path
        stage("Configuring File Reverse Proxy") {
            stages {
                // Config Service Upstream
                stage('Config Service Upstream') {
                    steps {
                        echo "Config Service Upstream"
                    }
                }
                // Config Service URL Path
                stage('Config Service URL Path') {
                    steps {
                        echo "Config Service URL Path"
                    }
                }
            }
        }
        stage("Testing Reverse Proxy Config") {
            steps {
                sh '/usr/sbin/nginx -t'
            }           
        }
        stage("Restarting Reverse Proxy Service") {
            steps {
                sh 'service nginx restart'
            }           
        }
    }
}