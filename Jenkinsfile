pipeline {
    agent {
        node {
            label 'agent_rails_elminster'
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                script {
                    sh('''
                        . ~/.rvm/scripts/rvm &> /dev/null
                        rvm install 2.7.2
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
                            . ~/.rvm/scripts/rvm &> /dev/null
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
                            sh """. ~/.rvm/scripts/rvm &> /dev/null
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
        stage('Update github') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'jenkins-github', keyFileVariable: 'github-ssh', passphraseVariable: '', usernameVariable: 'github-user')]) {
                        def githubBranch = env.BRANCH_NAME;
                        sh '''
                            if git remote | grep github > /dev/null; then                           
                            else
                                git remote add github https://github.com/tititoof/chartman2-backend.git
                            fi
                        '''
                        sh """
                            if git ls-remote --heads github $githubBranch ; then
                            else
                                git push -u github $githubBranch
                            fi
                        """
                        sh "git push --force github $githubBranch"
                        
                    }
                    echo 'Github finished'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}