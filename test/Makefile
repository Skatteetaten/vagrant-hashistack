.ONESHELL .PHONY: test clean add_local_box test_nomad_job run
.DEFAULT_GOAL := run

add_local_box:
	vagrant box add ../packer/output-hashistack/package.box --name local/hashistack --force

run: add_local_box
	vagrant up

clean:
	vagrant destroy -f

test_nomad_job:
	vagrant ssh -c 'cd /vagrant; nomad run countdash.hcl'
	sleep 10
	vagrant ssh -c 'nomad status countdash.'

test: clean run test_nomad_job