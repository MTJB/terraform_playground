variable "db-admin-username" {
  type    = string
  default = "db-sa"
}

variable "db_collation" {
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "db_sku" {
  type    = string
  default = "GP_Gen5_2"
}

variable "location" {}

variable "name" {}

variable "num_read_replicas" {
  default = 0
}

variable "resource_group" {}

variable "sql-server-version" {
  type    = string
  default = "12.0"
}

variable "firewalls" {
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

# Additional users (and permissions) to assign to the created database
variable "db_users" {
  type = list(object({
    name  = string
    roles = list(string)
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}