terraform {
  required_version = ">= 1.10"

  backend "s3" {
    bucket       = "tfstate-242944508335-us-east-1"
    key          = "sandbox/backend-test/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # blocks two runs at the same time
  }
}

# A built-in "do nothing" resource. It builds nothing in AWS,
# but it still writes to the state file, which is all we need here.
resource "terraform_data" "hello" {
  input = "remote state works"
}
