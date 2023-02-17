module "deploy-support-bucket" {
  source = "./modules/deploy_support_bucket"

  database-directory = "${var.root_directory}/${var.db_dir_name}"
}


module "database" {
  source = "./modules/database"

  database-name = "photo-share-site"
}