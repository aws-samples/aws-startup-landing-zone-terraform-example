output "arn" {
  value     = aws_internet_gateway.main.arn
  sensitive = true
}

output "id" {
  value = aws_internet_gateway.main.id
}
