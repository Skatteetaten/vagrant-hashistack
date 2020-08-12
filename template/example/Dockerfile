FROM hashicorpnomad/counter-api:v1

# Allow buildtime config
ARG TEST_DOWNLOAD_BUILD_ARGUMENT

# Test download
RUN \
    apk add curl && \
    curl -s -I -o /dev/null $TEST_DOWNLOAD_BUILD_ARGUMENT || echo -e "\n###############\nERROR: You are probably behind a corporate proxy. \n###############\n"