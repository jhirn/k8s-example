plugin "aws" {
  enabled = true
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.28.0"
}

config {
  call_module_type = "local"
  force            = false
}
