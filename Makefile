install:
	lxc launch images:ubuntu/xenial pirus
	lxc exec pirus -- apt install -y curl jq
	lxc exec pirus -- mkdir -p /pipeline/{job,inputs,outputs,logs,db}

	lxc file push form.json pirus /pipeline/form.json
	lxc file push icon.png pirus /pipeline/icon.png
	lxc file push run.sh pirus /pipeline/job/run.sh
	lxc exec pirus -- chmod +x /pipeline/job/run.sh

	lxc stop pirus
	lxc publish pirus --alias=LxdPirus_TestUnitaire

	lxc image export LxdPirus_TestUnitaire
	ls | grep ".tar.gz" | awk '{print $1}' | xargs sudo tar xf
	ls | grep ".tar.gz" | awk '{print $1}' | xargs sudo rm

	sudo tar cfz LxdPirus_TestUnitaire.tar.gz metadata.yaml rootfs templates
	cp new_metadata.yaml metadata.yaml
	sudo rm -fr metadata.yaml rootfs templates
	sudo chown $USER:$USER LxdPirus_TestUnitaire.tar.xz


clean:
	sudo rm -fr metadata.yaml rootfs templates 