terraform {
  required_providers {
    qovery = {
      source = "qovery/qovery"
    }
    aiven = {
      source  = "aiven/aiven"
      version = "~> 3.9.0"
    }
  }
}

provider "qovery" {
  token = var.qovery_access_token
}

provider "aiven" {
  api_token = var.aiven_api_token
}

resource "aiven_pg" "pg-sebi" {
  project                 = var.aiven_project_name
  cloud_name              = "google-europe-west1"
  plan                    = "startup-4"
  service_name            = "pg-sebi"
  maintenance_window_dow  = "monday"
  maintenance_window_time = "10:00:00"
}

resource "qovery_environment" "development" {
  cluster_id = "9574c320-54af-496b-848c-798a72ea0a01"
  project_id = "9796d613-edf7-4bd3-8326-dd674246a9b6"
  name       = "development"
  mode       = "DEVELOPMENT"
}

resource "qovery_container" "todo-quarkus" {
  environment_id = qovery_environment.development.id
  registry_id    = "2e09eb1c-e535-4977-ae53-f4ce343eecea"
  name           = "todo-quarkus"
  image_name     = "sebi2706/todo-quarkus"
  tag            = "1.0.3"

  ports = [
    {
      internal_port       = 8080
      external_port       = 443
      protocol            = "HTTP"
      publicly_accessible = true
    }
  ]

  environment_variables = [
    {
      key   = "QUARKUS_DATASOURCE_USERNAME"
      value = "${aiven_pg.pg-sebi.service_username}"
    },
     {
      key   = "QUARKUS_DATASOURCE_JDBC_URL"
      value = "jdbc:postgresql://${aiven_pg.pg-sebi.service_host}:${aiven_pg.pg-sebi.service_port}/defaultdb"
    },
     {
      key   = "QUARKUS_DATASOURCE_DB_KIND"
      value = "postgresql"
    }
  ]
  secrets = [
    {
      key   = "QUARKUS_DATASOURCE_PASSWORD"
      value = "${aiven_pg.pg-sebi.service_password}"
    }
  ]

  depends_on = [
    qovery_environment.development,
    aiven_pg.pg-sebi
  ]

}
