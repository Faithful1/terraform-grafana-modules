module "image" {
    source = "./image" 
    image_in = var.image[terraform.workspace] //this will access the key within the image map that corresponds to the workspace
}