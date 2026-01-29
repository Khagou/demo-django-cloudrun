variable "project_id" { 
    type = string 
}
variable "region" { 
    type = string  
    default = "europe-west1" 
}

variable "repo_id" { 
    type = string 
    default = "demo" 
}
variable "service_name" { 
    type = string 
    default = "django-demo" 
}

# Image complète dans AR (avec tag)
# ex: europe-west1-docker.pkg.dev/PROJECT/demo/django-demo:latest
variable "image" { 
    type = string 
}
