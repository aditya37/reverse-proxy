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
                               fileExists("${env.WORKSPACE}"+'/api_upstream.d') || 
                               fileExists("${env.WORKSPACE}"+'/api_conf.d') ||
                               fileExists("${env.WORKSPACE}"+'/grpc_upstream.d')
                            ) {
                                return true
                            }else {
                                error "Folder api_upstream.d or api_conf.d,grpc_upstream.d not found"
                                echo "Folder api_upstream.d or api_conf.d,grpc_upstream.d not found"
                            }
                        }

                    }
                }
                // Config Service Upstream (rest api)
                stage('Config Service Upstream & Url Path') {
                    environment {
                        API_CONF_PATH="/home/reverse_proxy/api_conf.d/"
                        API_CONF_UPSTREAM_PATH="/home/reverse_proxy/api_upstream.d/"
                    }
                    steps {
                        echo "Change permission file copy_api_conf.sh"
                        sh 'chmod +x copy_api_conf.sh'
                        echo "Config Service URL Path"
                        sh "./copy_api_conf.sh $API_CONF_PATH"
                        echo "Change permission file copy_api_upstream_conf.sh"
                        sh 'chmod +x copy_api_upstream_conf.sh'
                        echo "Config Service Upstream"
                        sh "./copy_api_upstream_conf.sh $API_CONF_UPSTREAM_PATH"
                    }
                }
                stage("Config gRPC Upstream") {
                    environment {
                        GRPC_CONF_UPSTREAM_PATH="/home/reverse_proxy/grpc_upstream.d/"
                    }
                    steps {
                        echo "Change permission file copy_grcp_upstream_conf.sh"
                        sh 'chmod +x copy_grpc_upstream_conf.sh'
                        echo "Config gRPC Service Upstream"
                        sh "./copy_grpc_upstream_conf.sh $GRPC_CONF_UPSTREAM_PATH"
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