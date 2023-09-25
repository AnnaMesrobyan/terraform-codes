output "ansible_hosts_private_ip" {
  
  value = [ aws_instance.ansible_host1.private_ip, aws_instance.ansible_host2.private_ip ]
}
