output "consul_server_ip" {
  value = aws_instance.consul_server.public_ip
}

output "backend_service_ip" {
  value = aws_instance.backend_service.public_ip
}

output "backend_service-2_ip" {
  value = aws_instance.backend_service_2.public_ip
}
output "nginx_load_balancer_ip" {
  value = aws_instance.nginx_load_balancer.public_ip
}

