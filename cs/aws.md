# Reference Computation AWS

## Links

- Docs
  - https://docs.aws.amazon.com/cli/latest/reference/
  - https://docs.aws.amazon.com/sdkref/latest/guide/overview.html
- Repos
  - https://github.com/aws/aws-cli
  - https://github.com/awslabs/awscli-aliases/
- Videos
  - 2016 - The Effective AWS CLI User <https://www.youtube.com/watch?v=Xc1dHtWa9-Qa> (Kyle Knapp)
  - 2015 - Deep Dive: AWS LCI -  <https://www.youtube.com/watch?v=ZbgvG7yFoQI> (Thomas Jones)
  - 2015 - Automating AWS w/ AWS CLI - <https://www.youtube.com/watch?v=TnfqJYPjD9I> (James Saryerwinnie)

## Installing AWS CLI

Install AWS CLI VS2:
```bash
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscli.zip
unzip awscli.zip
aws/install -i ~/opt/aws-cli -b ~/opt/local/bin
```

Install JMESPath CLI (Integrated into aws cli but useful for operating on json output after the fact and/or testing):
```bash
wget https://github.com/jmespath/jp/releases/download/0.1.2/jp-linux-amd64 -O ~/opt/local/bin/jp
chmod +x ~/opt/local/bin/jp
```

- Notes:
  - `jp -u` for unquoted output
  - JSON Templates: `~/opt/aws-cli/v2/2.2.16/dist/botocore/data/ec2/2016-11-15/examples-1.json`
  - `[--query <JMESPath>] [--output <json|text|table>]`

## Notes


```bash
aws ec2 describe-instances --filters Name=architecture,Values=x86_64
aws ec2 describe-regions

# No error handling
aws ec2 create-tags --tags Key=purpose,Value=dev \
  --resources $(aws ec2 run-instances
    --image-id admi-12345 \
    --query Instances[].InstanceId \
    --output text)

# With error handling

instance_ids=$(
  aws ec2 run-instances
    --image-id admi-12345 \
    --query Instances[].InstanceId \
    --output text
) || errexit "Could not run instance"

aws ec2 create-tags \
  --tags Key=purpose,Value=dev \
  --resources "${instance_ids}" || errexit "<errmsg>"

aws iam list-users --query "Users[].[Username]" --output text \
  | xargs -I% -P10 aws iam delete-user --username "%"

# Use [Username] to get newline separated output

region_name="us-east-2"

aws ec2 describe-images \
  --filters \
    Name=owner-alias,Values=amazon \
    Name=name,Values="amzn-ami-hvm-*" \
    Name=architecture,Values=x86_64 \
    Name=virtualization-type,Values=hvm \
    Name=root-device-type,Values=ebs \
    Name=block-device-mapping.volume-type,Values=gp2 \
  --region "${region_name}" \
  --query "reverse(sort_by(Images[? !contains(Name, 'rc')], &CreationDate))
           [*].['$region_name', ImageId, Name, Description]" \
  --output text

instance_id=$(aws ec2 run-intances \
  --image-id "$image_id" \
  --key-name "$key_name" \
  --security-group-ids "$security_group" \
  --iam-instance-profile "Name=$ROLE_NAME" \
  --output text \
  --query "Instances[0].InstanceId")

aws ec2 create-tages \
  --resources=$instance_id \
  --tages Key=purpose,Value=dev-ec2-instance

aws ec2 wait instance-running --instance-ids $instance_id

hostname=$(aws ec2 describe-instances \
            --instance-ids "$instance_id" \
            --output text \
            --query Reservations[0].Instances[0].PublicDnsName)

---

aws ec2 wait console-output-available --instance-id $instance_id

fingerprint=$(aws ec2 get-console-output \
  --instance-id $instance_id --query Output --output text \
    | grep '^ec2.*RSA' | cut -d ' ' -f 3)

remote_fingerprint=$(ssh-keyscan -t rsa $hostname)

[[ $fingerprint = $remote_fingerprint ]] && echo $fingerprint >> ~/.ssh/known_hosts
```
