# Simple AWS CLI Sample with Lambda
Use three different methods via the CLI to create and invoke a Lambda. 
Create node and python lambda from simple make targets.

`makefile` uses these three different ways to configure the AWS CLI. Uncomment the one you want to use. 
```makefile
#AWS_CLI=AWS_PROFILE=localstack aws
#AWS_CLI=AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test aws --endpoint-url http://localhost:4566 --region us-east-1
#AWS_CLI=awslocal
```
!["Design"](./docs/img/solution-diags.drawio.png)


# Setup 
After you've cloned this repo.
You can either use a LocalStack AWS_PROFILE for credentials, or use `awslocal`. Setup options are directly below.

### With LocalStack Profile
1. Setup an AWS_PROFILE for LocalStack

#### Add this to your `~/.aws/config` file

```text
[profile localstack]
region=us-east-1
output=json
endpoint_url = http://localhost:4566
```

#### Add this to your `~/.aws/credentials` file

```text
[localstack]
aws_access_key_id=test
aws_secret_access_key=test
```


### With awslocal wrapper
1. Create a Python venv and activate it

      ```bash
      make setup-venv
      source venv/bin/activate
      ```
2. Change makefile to point at awslocal
```makefile
#AWS_CLI=AWS_PROFILE=localstack aws
#AWS_CLI=AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test aws --endpoint-url http://localhost:4566 --region us-east-1
AWS_CLI=awslocal
```

### With AWS CLI
Change makefile to point at aws CLI. Must be AWS CLI v2.
```makefile
#AWS_CLI=AWS_PROFILE=localstack aws
AWS_CLI=AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test aws --endpoint-url http://localhost:4566 --region us-east-1
#AWS_CLI=awslocal
```

## Run LocalStack
You can use LocalStack Pro, just see the commented out line in `docker-compose.yml`.

```shell
docker compose up
```

# Python Lambda Test
1. Build python function zip
```shell
make bundle-py
```
2. Deploy function
```shell
make create-py-function
```
3. Invoke function
```shell
make local-py-invoke
```
4. See results
```shell
cat output.txt
```

# Node Lambda Test
1. Build python function zip
```shell
make bundle
```
2. Deploy function
```shell
make create-function
```
3. Invoke function
```shell
make local-invoke
```
4. See results
```shell
cat output.txt
```

