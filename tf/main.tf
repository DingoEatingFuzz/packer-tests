data "hcp_packer_image_iteration" "test" {
  bucket_name = "test-example-west"
  channel = "test"
}

output "ami" {
  value = data.hcp_packer_image_iteration.test.builds[0].images[0].image_id
}
