resource "aws_sns_topic" "cost_alerts" {
  name = "cost-alerts"
}

resource "aws_sns_topic_subscription" "email_subscriptions" {
  count     = length(var.alert_emails)
  topic_arn = aws_sns_topic.cost_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_emails[count.index]
}