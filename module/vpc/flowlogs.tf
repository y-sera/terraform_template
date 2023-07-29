resource "aws_cloudwatch_log_group" "log_group_flowlog" {
  name              = "${var.prefix}-vpc-flowlog"
  retention_in_days = var.flowlog_retention_days

  tags = {
    Name = "${var.prefix}-vpc-flowlog"
  }
}

resource "aws_iam_role" "iam_role_flowlog" {
  name = "${var.prefix}-role-flowlog"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_doc_flowlog.json

  tags = {
    Name = "${var.prefix}-role-flowlog"
  }
}

resource "aws_iam_policy" "iam_policy_flowlog" {
  name = "${var.prefix}-iam-policy-flowlog"
  description = "for vpc flow log ${var.prefix}-vpc"

  policy = data.aws_iam_policy_document.policy_doc_flowlog.json

  tags = {
    Name = "${var.prefix}-iam-policy-flowlog"
  }
}

data "aws_iam_policy_document" "policy_doc_flowlog" {
  version = "2012-10-17"
  statement {
      effect = "Allow"
      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ]
      resources = ["*"]
      condition {
        test = "StringEquals"
        values = ["aws:SourceAccount"]
        variable = "${local.account_id}"
      }
    }
}   

data "aws_iam_policy_document" "assume_role_policy_doc_flowlog" {
  version = "2012-10-17"
  statement {
      effect = "Allow"
      principals {
        type = "Service"
        identifiers = ["vpc-flow-logs.amazonaws.com"]
      }
      actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_policy_attachment" "iam_attachment_flowlog" {
  name = "${var.prefix}-iam-policy-attachment"
  policy_arn = aws_iam_policy.iam_policy_flowlog.arn
  roles = [aws_iam_role.iam_role_flowlog.name]
}

resource "aws_flow_log" "flowlog" {
  vpc_id              = aws_vpc.vpc.id
  traffic_type = var.flowlog_type
  log_destination_type = "cloud-watch-logs"
  log_destination = aws_cloudwatch_log_group.log_group_flowlog.arn
  iam_role_arn = aws_iam_role.iam_role_flowlog.arn

  tags = {
    Name = "${var.prefix}-vpc-flowlog"
  }
}