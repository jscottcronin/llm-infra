variable "region" {
  default = "eu-west-1"
}

variable "project_name" {
  default = "llm-demo"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "container_image" {
  description = "Docker image for the FastAPI application"
}

variable "container_port" {
  default = 8000
}
