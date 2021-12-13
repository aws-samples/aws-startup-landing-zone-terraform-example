output "arn" {
  value     = aws_subnet.main.arn
  sensitive = true
}

output "id" {
  value = aws_subnet.main.id
}
