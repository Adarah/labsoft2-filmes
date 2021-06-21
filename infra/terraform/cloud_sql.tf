### Database instance setup

resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  database_version = "POSTGRES_13"
  region           = "us-central1"
  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    location_preference {
      zone = "us-central1-c"
    }
    ip_configuration {
      ipv4_enabled = true
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = false # Cannot be used with postgres
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "filmes" {
  name     = "filmes"
  instance = google_sql_database_instance.instance.name
}


### DB User and service account setup

variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

resource "google_sql_user" "backend-filmes" {
  instance = google_sql_database_instance.instance.name
  name     = var.db_username
  password = var.db_password
}
