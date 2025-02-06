variable "subnet-id" {
    description = "The Id of a subnet"
    type = string  
}

variable "assign-public-ip" {
    description = "Dynamically assigns a public Ip address to the instance"
    type = bool
    default = false
  }