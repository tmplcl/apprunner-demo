resource "aws_apprunner_connection" "this" {
  connection_name = "tmplcl-1"
  provider_type   = "GITHUB"

}

resource "aws_apprunner_service" "this" {
  service_name = "apprunner-demo"

  source_configuration {
    authentication_configuration {
      connection_arn = aws_apprunner_connection.this.arn
    }
    code_repository {
      repository_url = "https://github.com/tmplcl/apprunner-demo"
      source_code_version {
        type  = "BRANCH"
        value = "main"
      }
      code_configuration {
        configuration_source = "REPOSITORY"
      }
    }
  }

  tags = {
    Name = "example-apprunner-service"
  }
}
