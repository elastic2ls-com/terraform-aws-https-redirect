variable "project_name" {
  type        = string
  default     = "www-yourdomain-de"
  description = "General project prefix"
}

variable "source_domain" {
  type        = string
  default     = "www.yourdomain.de"
  description = "Domain which to redirect"
}

variable "target_domain" {
  type        = string
  default     = "www.otherdomain.de"
  description = "Domain to redirect request to"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}

variable "certificate_region" {
  type    = string
  default = "us-east-1"
}

variable "main_region" {
  type    = string
  default = "eu-central-1"
}
