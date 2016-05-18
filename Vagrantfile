Vagrant.configure("2") do |config|

	config.vm.box = "centos-7.2.1511"
	config.vm.box_url = "builds/centos-7.2.1511-x86_64-virtualbox.box"

    config.vm.provision "shell", inline: <<END_OF_SCRIPT
cat > /etc/hosts <<EOF
192.168.32.11 node01
192.168.32.12 node02
EOF
END_OF_SCRIPT

  (1..2).each do |n|
		hostname = "node-0#{n}"
		last = (n >= 2)
		ip = "192.168.32.1#{n}"
		disk2_path = Dir.pwd() + "/drvd-disk-" + "#{n}" + ".vmdk"

		config.vm.define hostname do |node|
			node.vm.network "private_network", ip: ip
			node.vm.hostname = hostname

			if last
				node.vm.provision "ansible" do |ansible|
					ansible.limit = "all"
					ansible.playbook = "playbook.yml"
					ansible.host_key_checking = false
					ansible.raw_ssh_args = '-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o IdentitiesOnly=yes'
					ansible.tags = ENV['ANSIBLE_TAGS']
				end
			end
    	
    		node.vm.provider :virtualbox do |v|
				v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
				v.customize ["modifyvm", :id, "--memory", 1024]
				v.customize ["modifyvm", :id, "--cpus", 1]
				v.customize ["modifyvm", :id, "--ioapic", "on"]
				# add an extra disk, this disk we're going to replicate using drbd
				v.customize ["createhd", "--filename", disk2_path, "--size", 10*1024, "--format", "vmdk"]
				v.customize ["storageattach", :id,  "--storagectl", "IDE Controller", "--port", 1, "--device", 0,  "--type", "hdd", "--medium", disk2_path]
    		end
		end
	end

    config.ssh.forward_agent = true 

end
