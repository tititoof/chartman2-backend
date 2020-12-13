pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                script {
                    sh('''
                        source /usr/local/rvm/scripts/rvm
                        rvm use 2.7.2
                        rvm -v
                        ruby -v
                        gem -v
                        gem install bundler
                    ''')
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                script {
                    withCredentials([string(credentialsId: 'chartman2-test-key', variable: 'TEST_CREDENTIALS')]) {
                        sh('''
                            source /usr/local/rvm/scripts/rvm
                            rvm use 2.7.2
                            bundle install
                            echo "$TEST_CREDENTIALS" > config/credentials/test.key
                            RAILS_ENV=test bundle exec rake db:create
                            RAILS_ENV=test bundle exec rake db:migrate
                            RAILS_ENV=test bundle exec rspec spec/* --format html --out rspec_results/results.html --format RspecJunitFormatter --out rspec_results/results.xml
                        ''')
                        try {
                            sh """source /usr/local/rvm/scripts/rvm 
                                bundle exec rubocop app spec --format json --out rubocop.json"""
                        } catch (err) {
                            echo "Rubocop error "
                            echo err.getMessage()
                        }
                        echo 'Finished tests!'
                    }
                }
            }
        }
        stage('SonarQube Quality Gate') {
            steps {
                echo 'Check quality..'
                script {
                    def scannerHome = tool 'sonarscanner';
                    def sonarqubeBranch = 'chartman2-backend-dev';
                    withSonarQubeEnv("sonarqube") {
                        if (env.BRANCH_NAME == 'master') {
                            sonarqubeBranch = 'chartman2-backend'
                        }
                        sh "${tool("sonarscanner")}/bin/sonar-scanner \
                                -Dsonar.projectKey=$sonarqubeBranch \
                                -Dsonar.sources='app, config, db, lib' \
                                -Dsonar.exclusions=app/assets/**/* \
                                -Dsonar.host.url=http://192.168.1.204:9080 \
                                -Dsonar.ruby.coverage.reportPaths=coverage/.resultset.json \
                                -Dsonar.login=dd720dccbf88391235e748c560c2be46672928c8"
                    }
                }
            }
        }
        stage("Quality Gate") {
            steps {
                script {
                    timeout(time: 1, unit: 'HOURS') {
                        def qualitygate = waitForQualityGate()
                        if (qualitygate.status != "OK") {
                            env.WORKSPACE = pwd()
                            error "Pipeline aborted due to quality gate coverage failure: ${qualitygate.status}"
                        }
                    }
                }
            }
        }
        stage('Test close') {
            steps {
                echo 'close....'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}