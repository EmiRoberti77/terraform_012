provider "aws" {
  region = "eu-west-2"
}

resource "aws_iam_user" "myUser" {
  name = "emiterraform"
}

resource "aws_iam_policy" "customPolicy" {
   name = "GlacierEFSEC2"
   policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"elasticfilesystem:*",
				"glacier:InitiateJob",
				"glacier:AbortMultipartUpload",
				"glacier:CreateVault",
				"glacier:ListTagsForVault",
				"glacier:DeleteVault",
				"glacier:DeleteArchive",
				"glacier:ListParts",
				"glacier:DeleteVaultNotifications",
				"glacier:ListJobs",
				"glacier:ListMultipartUploads",
				"glacier:SetVaultNotifications",
				"glacier:CompleteMultipartUpload",
				"glacier:InitiateMultipartUpload",
				"ec2:*",
				"glacier:UploadMultipartPart",
				"glacier:PurchaseProvisionedCapacity",
				"glacier:UploadArchive",
				"glacier:ListVaults",
				"glacier:ListProvisionedCapacity"
			],
			"Resource": "*"
		}
	]
}
EOF
}

resource "aws_iam_policy_attachment" "policyBind" {
  name = "attachment"
  users = [aws_iam_user.myUser.name]
  policy_arn = aws_iam_policy.customPolicy.arn
 }