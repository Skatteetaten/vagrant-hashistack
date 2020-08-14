FROM hashicorpnomad/counter-api:v1

# Allow buildtime config
ARG TEST_DOWNLOAD_BUILD_ARGUMENT

# Test download
RUN \
    apk --no-cache add curl=~7 && \
    curl -s -I -o /dev/null $TEST_DOWNLOAD_BUILD_ARGUMENT