terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "flask" {
  name = "saurabhkr24/flask-app:latest"
}

resource "docker_container" "flask" {
  name  = "flask-app-tf"
  image = docker_image.flask.name
  ports {
    internal = 5000
    external = 5000
  }
}
