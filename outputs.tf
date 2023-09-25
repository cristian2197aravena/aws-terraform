output "dns_load_balancer" {
  description = "DNS publica del Load balancer"
  value       = "http://${aws_lb.alb.dns_name}:${var.puerto_lb}"
}