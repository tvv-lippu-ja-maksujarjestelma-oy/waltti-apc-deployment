variable "secretname" {
  type = string
}

variable "vhost" {
  type = string
}

variable "topic_perms_read" {
  type = string
}

variable "topic_perms_write" {
  type = string
}

variable "user_perms_read" {
  type = string
  default = "^([amq\\.topic].*)$"
}

variable "user_perms_write" {
  type = string
  default = "^([amq\\.topic].*)$"
}
