# Run against all nodes

ansible-playbook node.yml -i inventory/hosts.cfg -u ubuntu --private-key ~/.ssh/personal_aws.pem
