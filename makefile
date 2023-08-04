AWS_CLI=AWS_PROFILE=localstack aws
#AWS_CLI=awslocal

setup-venv:
	python3 -m venv venv
	source venv/bin/activate && pip install -r requirements.txt


bundle:
	zip function.zip index.js

bundle-py:
	zip function-py.zip handler.py

create-js-function:
	$(AWS_CLI)  lambda create-function \
	--function-name localstack-lambda-url-example \
	--runtime nodejs18.x \
	--zip-file fileb://function.zip \
	--handler index.handler \
	--role arn:aws:iam::000000000000:role/lambda-role

create-py-function:
	$(AWS_CLI)  lambda create-function \
	--function-name localstack-py-lambda-url-example \
	--runtime python3.10 \
	--zip-file fileb://function-py.zip \
	--handler handler.lambda_handler \
	--role arn:aws:iam::000000000000:role/lambda-role


create-url:
	$(AWS_CLI) lambda create-function-url-config \
    --function-name localstack-lambda-url-example \
    --auth-type NONE

local-invoke:
	$(AWS_CLI) lambda invoke --function-name localstack-lambda-url-example \
	--cli-binary-format raw-in-base64-out \
	--payload '{"body": "{\"num1\": \"10\", \"num2\": \"10\"}" }' output.txt

local-py-invoke:
	$(AWS_CLI) lambda invoke --function-name localstack-py-lambda-url-example \
	--cli-binary-format raw-in-base64-out \
	--payload '{"body": "{\"num1\": \"10\", \"num2\": \"10\"}" }' output.txt

local-url-invoke:
	curl -X POST \
    'http://45w2i6g1zxvhlb0avvx2mg1l70fc98cl.lambda-url.us-east-1.localhost.localstack.cloud:4566/' \
    -H 'Content-Type: application/json' \
    -d '{"num1": "10", "num2": "10"}'