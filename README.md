# lambda-infra-template

## lambda が正しくただしく起動しているどうか

```bash
 aws lambda invoke \
  --function-name go-ecr-lambda \
  --payload '{}' \
  response.json \
  --log-type Tail \
  --query 'LogResult' \
  --output text | base64 --decode


START RequestId: 252ebf77-af42-4c2f-9c63-2386e9b687b2 Version: $LATEST
END RequestId: 252ebf77-af42-4c2f-9c63-2386e9b687b2
REPORT RequestId: 252ebf77-af42-4c2f-9c63-2386e9b687b2  Duration: 15.91 ms      Billed Duration: 1367 ms        Memory Size: 128 MB     Max Memory Used: 30 MB  Init Duration: 1350.15 ms

[nasunagisa@mac:~/Desktop/restapi-lambda-infra-template/aws/modules/network/api-gateway]+[main]
$

[nasunagisa@mac:~/Desktop/restapi-lambda-infra-template/aws/modules/network/api-gateway]+[main]
$ aws lambda invoke \
  --function-name go-ecr-lambda \
  --payload '{"httpMethod":"GET","body":""}' \
  response.json \
  --log-type Tail \
  --query 'LogResult' \
  --output text | base64 --decode


Invalid base64: "{"httpMethod":"GET","body":""}"
```

# restapi-lambda-dynamo-infra
