install:
	lxc launch images:ubuntu/xenial lxd-pirus-tu
	lxc exec --mode=non-interactive lxd-pirus-tu -- apt install -y curl jq --fix-missing
	lxc exec --mode=non-interactive lxd-pirus-tu -- mkdir -p /pipeline/{job,inputs,outputs,logs,db}

	lxc file push form.json lxd-pirus-tu /pipeline/form.json
	lxc file push icon.png lxd-pirus-tu /pipeline/icon.png
	lxc file push run.sh lxd-pirus-tu /pipeline/job/run.sh
	lxc exec --mode=non-interactive lxd-pirus-tu -- chmod +x /pipeline/job/run.sh

	lxc stop lxd-pirus-tu
	lxc publish lxd-pirus-tu --alias=LxdPirus_TestUnitaire

	lxc image export lxd-pirus-tu
	ls | grep ".tar.gz" | awk '{print $1}' | xargs sudo tar xf
	ls | grep ".tar.gz" | awk '{print $1}' | xargs sudo rm

	sudo tar cfz LxdPirus_TestUnitaire.tar.gz metadata.yaml rootfs templates
	cp new_metadata.yaml metadata.yaml
	sudo rm -fr metadata.yaml rootfs templates
	sudo chown $USER:$USER LxdPirus_TestUnitaire.tar.xz


clean:
	sudo rm -fr metadata.yaml rootfs templates 
	lxc list | grep "lxd-pirus-tu" | awk '{print $$2}' | xargs lxc delete --force
	lxc image list | grep "lxd-pirus-tu" | awk '{print $$2}' | xargs lxc image delete