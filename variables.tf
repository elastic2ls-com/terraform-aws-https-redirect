variable "project_name" {
  type        = string
  description = "General project prefix"
}

variable "source_domain" {
  type        = string
  description = "Domain which to redirect"
}

variable "target_domain" {
  type        = string
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

variable "stage" {
  type = string
  default = "stage"
  description = "the name of your stage"
}