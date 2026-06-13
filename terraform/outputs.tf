output "web_public_ip" {
  value = aws_instance.web.public_ip
}
output "db_private_ip" {
  value = aws_instance.db.private_ip
}
output "web_instance_id" {
  value = aws_instance.web.id
}
output "db_instance_id" {
  value = aws_instance.db.id
}
output "web_instance_type" {
  value = aws_instance.web.instance_type
}
output "db_instance_type" {
  value = aws_instance.db.instance_type
}
output "web_instance_az" {
  value = aws_instance.web.availability_zone
}
output "db_instance_az" {
  value = aws_instance.db.availability_zone
}
output "web_private_ip" {
  value = aws_instance.web.private_ip
}
