variable "region" {
  type     = string
  default  = "eu-central-1"
  nullable = false
}

variable "instance_type" {
  description = "Type of instance to create"
  default     = "t3.micro"
}
`

