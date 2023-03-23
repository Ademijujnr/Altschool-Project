

# Create Route53 hosted zone
resource "aws_route53_zone" "hosted_zone" {
  name = var.domain.domain
}

# Get Kubernetes ingress service
data "kubernetes_service" "ingress-service" {
  metadata {
    name = "nginx-ingress-controller"
  }
  depends_on = [
    helm_release.nginx_ingress_controller
  ]
}

# Create Route53 record
resource "aws_route53_record" "record" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.domain.record
  type    = "CNAME"
  ttl     = "300"
  records = [data.kubernetes_service.ingress-service.status.0.load_balancer.0.ingress.0.hostname]
}

# Set domain nameservers using namedotcom provider
resource "namedotcom_domain_nameservers" "nameservers" {
  domain_name = var.domain.domain
  nameservers = aws_route53_zone.hosted_zone.name_servers
}
