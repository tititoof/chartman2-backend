pipeline {
    agent {
        node {
            label 'agent_rails_elminster'
        }
    }
    environment {
        GITHUB_CREDS = credentials('github-tititoof')
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
                    withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_CREDENTIALS')]) {
                        def githubBranch = env.BRANCH_NAME;
                        def giteaBranch = env.BRANCH_NAME;
                        if (env.BRANCH_NAME == 'master') {
                            githubBranch = 'main'
                        }
                        sh '''
                            if git remote | grep github > /dev/null; then
                                git remote rm github
                            fi
                            git remote add github https://$GITHUB_CREDENTIALS@github.com/${GITHUB_CREDS_USR}/chartman2-backend.git
                        '''
                        try {
                            
                            sh "git pull github"
                            sh "git push -u github $githubBranch"
                        } catch (err) {
                            echo "github error "
                            echo err.getMessage()
                        }
                        sh """
                            git checkout $giteaBranch
                            git push --set-upstream github $giteaBranch:$githubBranch
                        """
                        
                    }
                    echo 'Github finished'
                }
            }
        }
        stage('Deploy') {
            steps {
                if (env.BRANCH_NAME == 'master') {
                    echo 'Deploying....'
                    // withCredentials([file(credentialsId: PRIVATE_KEY, variable: 'my_private_key'),
                    //                 file(credentialsId: PUBLIC_KEY, variable: 'my_public_key')]) {
                    //     writeFile file: 'key/private.pem', text: readFile(my_private_key)
                    //     writeFile file: 'key/public.pem', text: readFile(my_public_key)
                    // }
                }
            }
        }
    }
}