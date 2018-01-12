# aws_cloudhelpers
code snippets for aws cloud management


#### Custom IAM policies

[User policy for EC2: ec2_restricted_policy.json](ec2_restricted_policy.json)

This policy is used for :
    - Launch instances only in certain region, vpc, subnet and security group
    - Can only control instance with Tag (User:${aws:username})
    - View only for all other ec2 resources 

