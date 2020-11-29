# OpenShift Let's Encrypt Job (AWS)

A `Job` that runs the Acme.sh script to generate Let's Encrypt certs for the "api" endpoint of your OpenShift cluster, as well as the "apps" wildcard subdomain.

This is only for AWS (Route53) currently.

Example to build the container- (update to tag with your repo name)
`docker build -t quay.io/85matthew/acme.sh-with-aws-iam-role:latest .`

To deploy the job and required components:
1) Clone this repo
2) Configure and update the AWS IAM Role that has Route53:* & sts:* permissions to create/add the DNS records for letencrypt authentication (Assumes your cluster is IAM integrated- see for more info (https://www.openshift.com/blog/fine-grained-iam-roles-for-openshift-applications)
2) `oc apply -k job`

Done!

This will take a few minutes, but once the job succeeds, you should have good certs for your api endpoint as well as wildcard cert for your "apps" domain.
