# aws_cloudhelpers
code snippets for aws cloud management


#### Custom IAM policies

[ec2_restricted_policy.json](ec2_restricted_policy.json)

This policy is used for:
* Launch instances only in certain region, vpc, subnet and security group
* Can only control instance with Tag (User:_${aws:username}_)
* View only for all other ec2 resources 

