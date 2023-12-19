provider "aws" {
  version = "~> 5.0"
  region  = "us-east-2"
  profile = "default"
}
  variable "key_pair_name" {
  type    = string
  default = "assignment1"
}
resource "aws_instance" "ansible" {
  ami           = "ami-08978028fd061067a"  #Redhat AMI
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
   tags = {
    Owner = "Nigora"
    Name = "ansible_managed_host"
  }
}
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "stop_instance.py"
  output_path = "stop_instance.zip"
}
resource "aws_lambda_function" "stop_instance" {
  filename         = data.archive_file.lambda.output_path
  function_name    = "stop_instance"
  role             = aws_iam_role.lambda.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  
}
resource "aws_iam_role" "lambda" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "lambda" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda.name
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_instance.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_instance.arn
}
resource "aws_cloudwatch_event_rule" "stop_instance" {
  name                = "stop_instance"
  description         = "Stop EC2 instance every day after class"
  schedule_expression = "cron(0 15 * * ? *)"
}

resource "aws_cloudwatch_event_target" "stop_instance" {
  rule      = aws_cloudwatch_event_rule.stop_instance.name
  arn       = aws_lambda_function.stop_instance.arn
  target_id = "stop_instance"
}
