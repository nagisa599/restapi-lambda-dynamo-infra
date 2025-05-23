# ---------------------------------------------------------
# API Gateway
# ---------------------------------------------------------
resource "aws_api_gateway_rest_api" "myapi" {
  name        = "serviceA(nagisa)"
  description = "ServiceA"
}

# ----------------------------------------------------------
# パスの指定
# -----------------------------------------------------------
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id
  path_part   = "test"
}

# -------------------------------------------------
# パスのメソッドを定義
# -------------------------------------------------
locals {
  methods = ["GET", "POST", "PUT", "DELETE"]
}
resource "aws_api_gateway_method" "proxy_methods" {
  for_each       = toset(local.methods)
  rest_api_id    = aws_api_gateway_rest_api.myapi.id
  resource_id    = aws_api_gateway_resource.proxy.id
  http_method    = each.key
  authorization  = "NONE"
}

# -------------------------------------------------
# 接続先Lambdaの定義
# -------------------------------------------------
resource "aws_api_gateway_integration" "lambda_integrations" {
  for_each = toset(local.methods)
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = each.key
  integration_http_method = "POST" # Lambdaを呼ぶときは常にPOST
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:ap-northeast-1:lambda:path/2015-03-31/functions/${var.lambda_invoke_arn}/invocations"

  depends_on = [aws_api_gateway_method.proxy_methods]
}
# -------------------------------------------------
# deployment
# -------------------------------------------------
resource "aws_api_gateway_deployment" "this" {
  depends_on = [
    aws_api_gateway_integration.lambda_integrations,
    aws_api_gateway_method.proxy_methods
  ]

  rest_api_id = aws_api_gateway_rest_api.myapi.id
  stage_name  = var.env # ステージ名（URLに出てくる）
}