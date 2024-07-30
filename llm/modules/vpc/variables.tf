variable "name" {}
variable "cidr" {}
variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = 3
}
