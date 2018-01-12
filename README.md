# aws_cloudhelpers
code snippets for aws cloud management


#### Custom IAM policies

[ec2_restricted_policy.json](ec2_restricted_policy.json)

This policy is used for:
* Launch instances only in certain region, vpc, subnet and security group
* Can only control instance with Tag (User:_${aws:username}_)
* View only for all other ec2 resources 

[iam\_selfmanage_mfa.json](iam_selfmanage_mfa.json)

This policy allows IAM users to self-manage their MFA devie:

* Create, Enable, Resync & DeleteVirtual MFA device
* Deactivate their own virtual mfa device
* List/view MFA devices and users