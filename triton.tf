provider "triton" {
  version      = "~>0.2.1"
  account      = "${var.account}"
  key_id       = "${var.key_id}"
  key_material = "${file(var.key_path)}"
}

resource "triton_machine" "dcos-agent-priv" {
  count   = 3
  name    = "${format("dcos-agent-priv-%03d", count.index + 1)}"
  image   = "66d919a8-132a-11e7-a7b8-5b99fa122880"
  package = "d8142625-5814-ceb0-89e3-f1d6fef0a0a6"

nic = {
  network = "05909d29-7c4f-4c04-9dab-dad2068de161"
}

  tags {
    role = "agent_priv"
  }

  connection {
    host = "${self.primaryip}"
    private_key = "${file(var.key_path)}"
  }

  provisioner "remote-exec" {
    inline = ["/bin/true"]
  }
}

resource "triton_machine" "dcos-agent-pub" {
  count   = 1
  name    = "${format("dcos-agent-pub-%03d", count.index + 1)}"
  image   = "66d919a8-132a-11e7-a7b8-5b99fa122880"
  package = "a8bf4ab3-5816-e250-870e-984b0eca7846"

nic = {
  network = "05909d29-7c4f-4c04-9dab-dad2068de161"
}

  tags {
    role = "agent_pub"
  }

  connection {
    host = "${self.primaryip}"
    private_key = "${file(var.key_path)}"
  }

  provisioner "remote-exec" {
    inline = ["/bin/true"]
  }
}



resource "triton_machine" "dcos-bootstrap" {
  name    = "dcos-bootstrap"
  image   = "66d919a8-132a-11e7-a7b8-5b99fa122880"
  package = "dcos-boot"

nic = { 
  network = "05909d29-7c4f-4c04-9dab-dad2068de161"
}

  tags {
    role = "bootstrap"
  }

  connection {
    host        = "${self.primaryip}"
    private_key = "${file(var.key_path)}"
  }

  provisioner "remote-exec" {
    inline = ["/bin/true"]
  }
}

resource "triton_machine" "dcos-master" {
  count   = 1
  name    = "${format("dcos-master-%03d", count.index + 1)}"
  image   = "66d919a8-132a-11e7-a7b8-5b99fa122880"
  package = "247347f3-1427-6351-fb6d-edb3c38a23ab"

nic = {
  network = "05909d29-7c4f-4c04-9dab-dad2068de161"
}


  tags {
    role = "master"
  }

  connection {
    host        = "${self.primaryip}"
    private_key = "${file(var.key_path)}"
  }

  provisioner "remote-exec" {
    inline = ["/bin/true"]
  }
}
