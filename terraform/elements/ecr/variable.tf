variable "name" {
  description = "The name of repository"
  type = string
}
variable "image_tag_mutability" {
  description = "The tag immutability flags"
  type = string
  default = "IMMUTABLE"
}
variable "scan_image_on_push" {
  description = "The flag of scan"
  type = bool
  default = true
}
variable "encryption_configuration" {
  type = object({
    encryption_type = string
    kms_key = any
  })
  description = "ECR encryption configuration"
  default     = null
}
variable "lifecycle_policy" {
  type = string
  default = ""
}

variable "tags" {
  type = map(string)
  default = {}
}
