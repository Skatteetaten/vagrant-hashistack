# Docker build directory

Put your Dockerfile and other files relating to a docker-build here.

## Building docker image locally

If you have docker installed on your machine, you may `cd docker; docker build -t my_image:local .`  and build the image.

This image can be built and operated behind a corporate proxy where the base os needs to trust a custom CA.
While building locally using the Makefile, you may set the environment variable CUSTOM_CA to a custom .crt file in order to import it into the docker image. See [conf/certificates](conf/certificates)

See [../template_example/docker/Dockerfile](../template_example/docker/Dockerfile) for examples on how to import and trust CA for centos/debian/alpine based docker images.

## Building and testing the docker-image within the vagrant-hashistack box

We advise you to build and test your docker image within the hashistack eco-system. Running `make test` will launch the [default playbook](../dev/ansible/playbook.yml) inside the box, and [template_example/](../template_example/) shows a simple build process for building and running the docker image using this. Refer to books in [template_example/dev/ansible](../template_example/dev/ansible) to see details.
