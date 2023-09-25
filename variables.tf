variable "puerto_servidor" {
  description = "Puerto para las instancias EC2"
  type        = number
  default     = 8080

  // tiene dos argumentos
  validation {
    condition     = var.puerto_servidor > 0 && var.puerto_servidor <= 65536      // se tiene que evaluar por true o false de tipo bool
    error_message = "El valor del puerto debe estar comprendido entre 1 y 65536" //// un string que indica por que ha fallado
  }

}

variable "puerto_lb" {
  description = "Puerto para el LB"
  type        = number
  default     = 80
}

variable "tipo_instancia" {
  description = "Tipo de las instancias EC2"
  type        = string
  default     = "t2.micro"
}

variable "ubuntu_ami" {
  description = "AMI por region"
  type        = map(string)

  default = {
    eu-west-1 = "ami-0136ddddd07f0584f"
    us-est-2  = "ami-0c65adc9a5c1b5d7c"
  }
}

variable "servidores" {
  description = "Mapa de servidores con nombres y AZs"

  // tipo map donde cada elemtno del mapa seria un objeto
  type = map(object({
    nombre = string,
    az     = string
  }))

  default = {
    "ser-1" = { nombre = "servidor-1", az = "a" },
    "ser-2" = { nombre = "servidor-2", az = "b" }
  }
}
