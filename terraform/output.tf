output "consul1_ip" {
  value = aws_instance.consul_server.public_ip
}

output "backend1_ip" {
  value = aws_instance.backend_service.public_ip
}

output "backend2_ip" {
  value = aws_instance.backend_service_2.public_ip
}
output "loadbalancer1_ip" {
  value = aws_instance.nginx_load_balancer.public_ip
}

