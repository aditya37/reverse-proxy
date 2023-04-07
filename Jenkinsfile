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
                // checking config directory
                stage('Checking Config directory') {
                    steps {
                        echo "Checking Config Directory"  
                        script {
                           if (
                               fileExists("${env.WORKSPACE}"+'/api_upstream.d') || fileExists("${env.WORKSPACE}"+'/api_conf.d')
                            ) {
                                return true
                            }else {
                                error "Folder api_upstream.d or api_conf.d not found"
                                echo "Folder api_upstream.d or api_conf.d not found"
                            }
                        }

                    }
                }
                // Config Service Upstream
                stage('Config Service Upstream & Url Path') {
                    steps {
                        echo "Config Service Upstream"
                        echo "Config Service URL Path"
                        sh 'ls'
                    }
                }
            }
        }
        // Testing Reverse Proxy Config
        stage("Testing Reverse Proxy Config") {
            steps {
                echo 'Checking config reverse proxy'
                sh '/usr/sbin/nginx -t'
            }           
        }
        // Restarting Reverse Proxy Service
        stage("Restarting Reverse Proxy Service") {
            steps {
                echo 'restarting service nginx'
                sh 'service nginx restart'
            }           
        }
    }
}