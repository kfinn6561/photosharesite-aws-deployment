module "network" {
  source = "./modules/network"
}


module "deploy-support-bucket" {
  source = "./modules/deploy_support_bucket"

  database-directory = pathexpand("${var.root_directory}/${var.db_dir_name}")
}


module "database" {
  source = "./modules/database"

  database-name            = "photosharesite"
  db-username              = "photosharesite-user"
  bucket-reader-policy-arn = module.deploy-support-bucket.bucket-reader-policy-arn
  deploy-support-bucket-id = module.deploy-support-bucket.bucket-id

  depends_on = [module.deploy-support-bucket]
}