resource "docker_image" "nginx_web" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_servidor" {
  image = docker_image.nginx_web.image_id
  name  = "servidor-nginx-v2"
  
  ports {
    internal = 80
    external = var.puerto_externo
  }
}