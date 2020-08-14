# Docker build directory

Put your Dockerfile and other files relating to a docker-build here.

## Building docker image locally

If you have docker installed on your machine, you may `cd docker; docker build -t my_image:local .`  and build the image.

## Building and testing the docker-image within the vagrant-hashistack box

We advise you to build and test your docker image within the hashistack eco-system. Running `make test` will launch the [default playbook](../dev/ansible/playbook.yml) inside the box, and [test_example/](../test_example/) shows a simple build process for building and running the docker image using this. Refer to books in [test_example/dev/ansible](../test_example/dev/ansible) to see details. 
