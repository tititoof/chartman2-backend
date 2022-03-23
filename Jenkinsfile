pipeline {
    agent {
        node {
            label 'agent_rails_1'
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                script {
                    sh '''
                        . ~/.rvm/scripts/rvm
                        rvm install ruby-3.1.1
                        rvm use ruby-3.1.1
                        rvm -v
                        ruby -v
                        gem -v
                        gem install bundler
                        bundle update --bundler
                    '''
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
                            rvm use ruby-3.1.1
                            gem cleanup
                            bundle install
                            echo "$TEST_CREDENTIALS" > config/credentials/test.key
                            RAILS_ENV=test bundle exec rake db:create
                            RAILS_ENV=test bundle exec rake db:migrate
                            RAILS_ENV=test bundle exec rspec spec/* --format html --out rspec_results/results.html --format RspecJunitFormatter --out rspec_results/results.xml
                            ruby -rjson -e 'sqube = JSON.load(File.read("coverage/.resultset.json"))["RSpec"]["coverage"].transform_values {|lines| lines["lines"]}; total = { "RSpec" => { "coverage" => sqube, "timestamp" => Time.now.to_i }}; puts JSON.dump(total)' > coverage/.resultset.solarqube.json
                        ''')
                        try {
                            sh """
                                . ~/.rvm/scripts/rvm &> /dev/null
                                rvm use ruby-3.1.1
                                gem install rubocop
                                bundle exec rubocop app --format json --out rubocop-result.json"""
                        } catch (err) {
                            echo "Rubocop error "
                            echo err.getMessage()
                        }
                        sh """
                            rvm use ruby-3.1.1
                            bundle exec brakeman -A -q --color -o /dev/stdout -o brakeman.json
                        """
                        echo 'Finished tests!'
                    }
                }
            }
        }
        stage('SonarQube Quality Gate') {
            steps {
                echo 'Check quality..'
                script {
                    def scannerHome = tool 'sonarqube-scanner';
                    def sonarqubeBranch = 'chartman2-backend-dev';
                    withCredentials([string(credentialsId: 'sonarqube-server', variable: 'SONAR_URL')]) {
                        withCredentials([string(credentialsId: 'sonarqubeId', variable: 'SONAR_CREDENTIALS')]) {
                            withSonarQubeEnv("sonarqube") {
                                if (env.BRANCH_NAME == 'main') {
                                    sonarqubeBranch = 'chartman2-backend'
                                }
                                sh """${scannerHome}/bin/sonar-scanner \
                                        -Dsonar.projectKey=$sonarqubeBranch \
                                        -Dsonar.sources='app' \
                                        -Dsonar.exclusions=app/assets/**/* \
                                        -Dsonar.host.url=$SONAR_URL \
                                        -Dsonar.ruby.coverage.reportPaths=coverage/.resultset.solarqube.json \
                                        -Dsonar.ruby.rubocop.reportPaths=rubocop-result.json \
                                        -Dsonar.login=$SONAR_CREDENTIALS"""
                            }
                        }
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
                    def giteaBranch = env.BRANCH_NAME;
                    if (env.BRANCH_NAME.startsWith('PR')) {
                        echo "PR branch"
                    } else {
                        if (env.BRANCH_NAME == 'main') {
                            withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_CREDENTIALS')]) {
                                sh '''
                                    git config --global user.email "chartmann.35@gmail.com"
                                    git config --global user.name "Christophe Hartmann"
                                    if git remote | grep github > /dev/null; then
                                        git remote rm github
                                    fi
                                    git remote add github https://$GITHUB_CREDENTIALS@github.com/tititoof/chartman2-backend.git
                                '''
                                try {
                                    sh """
                                        git rm ./config/deploy/production.rb
                                    """
                                } catch (err) {
                                    echo err.getMessage()
                                }
                                sh """
                                    git add .
                                    git commit -m "Github update"
                                    git push -f github HEAD:main
                                """
                            }
                        }
                        echo 'Github finished'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        echo 'Deploying....'
                        withCredentials([file(credentialsId: 'capistrano-chartman2-backend', variable: 'DeployFile')]) {
                            writeFile file: 'config/deploy/production.rb', text: readFile(DeployFile)
                            sh('''
                                . ~/.rvm/scripts/rvm &> /dev/null
                                rvm use ruby-3.0.2
                                gem cleanup
                                bundle install
                                bundle exec cap production deploy
                            ''')
                        }
                    }
                }
            }
        }
    }
}