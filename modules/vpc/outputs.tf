output "arn" {
  value     = aws_vpc.main.arn
  sensitive = true
}

output "id" {
  value = aws_vpc.main.id
}
