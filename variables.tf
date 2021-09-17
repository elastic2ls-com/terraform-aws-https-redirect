variable "project_name" {
  type        = string
  default     = "booking-camperdays-de"
  description = "General project prefix"
}

variable "source_domain" {
  type        = string
  default     = "booking.camperdays.de"
  description = "Domain which to redirect"
}

variable "target_domain" {
  type        = string
  default     = "www.camperdays.de"
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
