pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                script {
                    sh('''
                        if ! command -v rvm &> /dev/null
                        then
                            gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
                            curl -sSL https://get.rvm.io | sudo bash -s stable
                            rvm install 2.7.2
                        fi
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
                            gem cleanup
                            bundle install
                            echo "$TEST_CREDENTIALS" > config/credentials/test.key
                            RAILS_ENV=test bundle exec rake db:create
                            RAILS_ENV=test bundle exec rake db:migrate
                            RAILS_ENV=test bundle exec rspec spec/* --format html --out rspec_results/results.html --format RspecJunitFormatter --out rspec_results/results.xml
                            ruby -rjson -e 'sqube = JSON.load(File.read("coverage/.resultset.json"))["RSpec"]["coverage"].transform_values {|lines| lines["lines"]}; total = { "RSpec" => { "coverage" => sqube, "timestamp" => Time.now.to_i }}; puts JSON.dump(total)' > coverage/.resultset.solarqube.json
                        ''')
                        try {
                            sh """source /usr/local/rvm/scripts/rvm
                                rvm use 2.7.2
                                gem install rubocop
                                bundle exec rubocop app spec --format json --out rubocop-result.json"""
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
                                -Dsonar.sources='app, lib' \
                                -Dsonar.exclusions=app/assets/**/* \
                                -Dsonar.host.url=http://192.168.1.204:9080 \
                                -Dsonar.ruby.coverage.reportPaths=coverage/.resultset.solarqube.json \
                                -Dsonar.ruby.rubocop.reportPaths=rubocop-result.json \
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