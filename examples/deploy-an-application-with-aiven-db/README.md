# Deploy an Application and an Aiven Database (PostgreSQL)

This ready to use example show you how to deploy a containerizes app (Quarkus Todo App) with PostgreSQL on Aiven. All of that in just a few lines of Terraform file.

## Behind the scene

Behind the scene, Qovery:

1. Creates Qovery resources:
   1. Environment `aiven-development`
   2. Application `todo-quarkus`
2. Creates PostgreSQL database using Aiven
3. Exposes publicly via HTTPS your `todo-quarkus` app

## How to use

1. Clone this repository
2. Sign in to [Qovery](https://www.qovery.com)
3. Install the [Qovery CLI](https://hub.qovery.com/docs/using-qovery/interface/cli/) and [generate an API Token](https://hub.qovery.com/docs/using-qovery/interface/cli/#generate-api-token) with this guide.
4. Generate your Aiven Token with [this guide](https://docs.aiven.io/docs/platform/howto/create_authentication_token)
5. Open you terminal and run the following command by changing the values:

```shell
export TF_VAR_aiven_api_token=YOUR_AIVEN_API_TOKEN \
TF_VAR_aiven_project_name=YOUR_AIVEN_PROJECT_NAME \
TF_VAR_qovery_access_token=YOUR_QOVERY_API_TOKEN \
TF_VAR_qovery_organization_id=YOUR_QOVERY_ORG_ID
```

> If you use this template in production, beware that you have some values to change in `variables.tf`

6. You can now run the Terraform commands

```shell
terraform init
```

```shell
terraform plan
```

```shell
terraform apply
```

7. Open your Qovery console to find out the HTTPS URL of your deployed app.
8. To tear down your infrastructure and avoid unnecessary cloud costs you can run `terraform destroy`.
