 output "ssh_private_key" {
 description = "The private key to use for SSH access. SAVE THIS IN A SAFE PLACE"
 value       = tls_private_key.mynewkey.private_key_pem
 sensitive   = true
 }
