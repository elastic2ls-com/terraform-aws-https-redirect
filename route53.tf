resource "aws_route53_zone" "this" {
  provider = aws.main
  name     = var.source_domain

  tags = merge(
    var.tags,
    {
      "Name" = var.project_name
    },
  )
}

resource "aws_route53_record" "this" {
  provider = aws.main
  zone_id  = aws_route53_zone.this.zone_id
  name     = var.source_domain
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}
