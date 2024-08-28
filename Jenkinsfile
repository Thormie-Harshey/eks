pipeline {
    agent { node { label 'terraform-node' } } 
    parameters {
                choice(name: 'deploy_choice', choices:['apply','destroy'],description:'The deployment type')
                  }
    environment {
        EMAIL_TO = 'tom.ashaye07@gmail.com'
    }
    stages {
        stage('1.Terraform init') {
            steps {
                echo 'terraform init phase'
                sh 'terraform init'
            }
        }
        stage('2.Terraform plan') {
            steps {
                echo 'terraform plan phase'
                sh 'AWS_REGION=us-east-1 terraform plan'
            }
        }
        stage('3.Manual Approval') {
            input {
                message "Should we proceed?"
                ok "Yes, we should."
                parameters{
                    choice (name: 'Manual_Approval', choices: ['Approve','Reject'], description: 'Approve or Reject the deployment')
                }
            }
             steps {
                echo "Deployment ${Manual_Approval}"
            }          
        }
        stage('4.Terraform Deploy') {              
            steps { 
                echo 'Terraform ${params.deploy_choice} phase'  
                sh "AWS_REGION=us-east-1 terraform ${params.deploy_choice}  -target=module.vpc -target=module.eks --auto-approve"
                sh("""scripts/update-kubeconfig.sh""")
                sh "AWS_REGION=us-east-1 terraform ${params.deploy_choice} --auto-approve"
            }
                }
        stage ('5. Email Notification') {
            steps {
               mail bcc: 'tom.ashaye07@gmail.com', body: '''Terraform deployment is completed.
               Let me know if the changes looks okay.
               Thanks,
               Dominion System Technologes, 2024,
              +234 814 094 5675''', cc: 'tom.ashaye07@gmail.com', from: '', replyTo: '', subject: 'Terraform Infra deployment completed!!!', to: 'tom.ashaye07@gmail.com'
                          
               }    
          }
     }       
}   






