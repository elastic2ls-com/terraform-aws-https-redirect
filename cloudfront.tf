resource "aws_cloudfront_distribution" "this" {
  provider = aws.certificate_region

  origin {
    origin_id   = "origin-${var.source_domain}"
    domain_name = aws_s3_bucket.this.website_endpoint
    custom_origin_config {

      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  enabled      = true
  aliases      = [var.source_domain]
  price_class  = "PriceClass_100"
  http_version = "http2"

  default_cache_behavior {
    target_origin_id = "origin-${var.source_domain}"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 1200
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.this.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.1_2016"

  }
}