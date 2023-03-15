variable "location" {}

variable "name" {}

variable "environment" {
  type = string
}

# Additional firewalls rules as applicable to your use case - your laptop for testing?
variable "firewalls" {
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

# Database users for the application
variable "db_users" {
  type = list(object({
    name  = string
    roles = list(string)
  }))
  default = [
    {
      name  = "db_admin"
      roles = ["db_owner"]
    }
  ]
}