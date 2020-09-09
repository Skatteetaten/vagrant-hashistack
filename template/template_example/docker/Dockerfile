##########################################
########### READ THIS FIRST ##############
##########################################
## This docker build is special...      ##
## It wil leverage multi stage builds   ##
## to test centos/debian/alpine         ##
## certificate trust before building    ##
## the docker image used in the example ##
##########################################

FROM centos:8

# Allow buildtime config
ARG TEST_DOWNLOAD_BUILD_ARGUMENT=https://nrk.no

#Add ca_certificates to the image ( if trust is not already added through base image )
COPY conf/certificates /usr/share/pki/ca-trust-source/anchors/

#Install certs
RUN \
    #Update CA_Certs
    update-ca-trust 2>/dev/null || true && echo "NOTE: CA warnings suppressed." \
    #Test download ( does ssl trust work )
    && curl -s -L -o /dev/null ${TEST_DOWNLOAD_BUILD_ARGUMENT} || printf "\n###############\nERROR: You are probably behind a corporate proxy. Add your custom ca .crt in the conf/certificates docker build folder\n###############\n"

FROM debian:stretch

# Allow buildtime config
ARG TEST_DOWNLOAD_BUILD_ARGUMENT=https://nrk.no

#Add ca_certificates to the image ( if trust is not already added through base image )
COPY conf/certificates /usr/local/share/ca-certificates

#Install certs
# hadolint ignore=DL3015
RUN \
    #Update CA_Certs
    apt-get update && apt-get install --no-install-recommends -y curl=7.52.1-5+deb9u11 && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates 2>/dev/null || true && echo "NOTE: CA warnings suppressed." \
    #Test download ( does ssl trust work )
    && curl -s -L -o /dev/null ${TEST_DOWNLOAD_BUILD_ARGUMENT} || printf "\n###############\nERROR: You are probably behind a corporate proxy. Add your custom ca .crt in the conf/certificates docker build folder\n###############\n"


FROM hashicorpnomad/counter-api:v1

# Allow buildtime config
ARG TEST_DOWNLOAD_BUILD_ARGUMENT=https://nrk.no

#Add ca_certificates to the image ( if trust is not already added through base image )
COPY conf/certificates /usr/local/share/ca-certificates

RUN apk --no-cache add curl=~7 ca-certificates=~20190108 \
    && find /usr/local/share/ca-certificates -not -name "*.crt" -type f -delete \
    && update-ca-certificates 2>/dev/null || true && echo "NOTE: CA warnings suppressed." \
    # Test download
    && curl -s -L -o /dev/null ${TEST_DOWNLOAD_BUILD_ARGUMENT} || printf "\n###############\nERROR: You are probably behind a corporate proxy. Add your custom ca .crt in the conf/certificates docker build folder\n###############\n"
