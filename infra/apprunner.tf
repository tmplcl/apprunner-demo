resource "aws_apprunner_service" "this" {
  service_name = "apprunner-demo"

  source_configuration {
    code_repository {
      repository_url = "https://github.com/tmplcl/apprunner-demo"
      source_code_version {
        type  = "BRANCH"
        value = "main"
      }
      configuration_source = "REPOSITORY"
    }
  }

  tags = {
    Name = "example-apprunner-service"
  }
}
