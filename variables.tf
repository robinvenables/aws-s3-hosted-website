variable "root_domain_name" {
  description = "The root domain name for this website. The www. subdomain will redirect to this"
  type        = string
}

variable "region" {
  description = "The AWS region this website will be created in (e.g. eu-west-2)"
  type        = string
}

variable "pages" {
  description = "Names of the Index and Error pages to use"
  type        = map(any)
  default = {
    index = "index.html"
    error = "404.html"
  }
}

variable "access_logging" {
  description = "Enable logging for the website"
  type        = bool
  default     = false
}

variable "logging_bucket" {
  description = "Name and prefix for website logging bucket"
  type        = map(any)
  default = {
    name   = "none"
    prefix = "none"
  }
}
