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

module "media-files-bucket" {
  source = "./modules/media_files_bucket"
}

module "backend" {
  source = "./modules/backend"

  bucket-reader-policy-arn = module.media-files-bucket.bucket-reader-policy-arn
  bucket-writer-policy-arn = module.media-files-bucket.bucket-writer-policy-arn
  media-files-bucket-id    = module.media-files-bucket.bucket-id
}