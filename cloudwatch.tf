resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "billing-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period             = "21600"  # 6hours
  statistic          = "Maximum"
  threshold          = "2"      # $2 threshold
  alarm_description  = "Billing alarm when charges exceed $2"
  alarm_actions      = [aws_sns_topic.cost_alerts.arn]

  dimensions = {
    Currency = "USD"
  }
}