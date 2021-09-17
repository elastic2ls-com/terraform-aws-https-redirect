output "s3_domain" {
  value = aws_s3_bucket.this.website_endpoint
}

output "s3_zone_id" {
  value = aws_s3_bucket.this.hosted_zone_id
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_hosted_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}

output "route53_domain_name" {
  value = aws_route53_record.this.name
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.cert.arn
}