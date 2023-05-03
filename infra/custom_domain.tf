data aws_route53_zone this {
  name = "aws.tcio.tech"
}

resource "aws_apprunner_custom_domain_association" "this" {
  domain_name = "apprunner.aws.tcio.tech"
  service_arn = aws_apprunner_service.this.arn
}

resource "aws_route53_record" "record_1" {
  name    = tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[0].name
  type    = tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[0].type
  records = [tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[0].value]
  ttl     = 300
  zone_id = data.aws_route53_zone.this.id
}

resource "aws_route53_record" "record_2" {
  name    = tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[1].name
  type    = tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[1].type
  records = [tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[1].value]
  ttl     = 300
  zone_id = data.aws_route53_zone.this.id
}

resource "aws_route53_record" "record_3" {
  name    = tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[2].name
  type    = tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[2].type
  records = [tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)[2].value]
  ttl     = 300
  zone_id = data.aws_route53_zone.this.id
}

resource "aws_route53_record" "custom_domain" {
  name = aws_apprunner_custom_domain_association.this.domain_name
  alias {
    evaluate_target_health = false
    name                   = aws_apprunner_service.this.service_url
    zone_id                = "Z087551914Z2PCAU0QHMW" // ID from https://docs.aws.amazon.com/general/latest/gr/apprunner.html
  }
  zone_id = data.aws_route53_zone.this.id
  type    = "A"
}
