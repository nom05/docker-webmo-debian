# syntax=docker/dockerfile:1
FROM debian:bullseye-slim

# Install packages needed by sitc script
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
            curl \
	          lsb-release \
	          sudo

# Copy sitc script to the image
COPY sitc.tar.gz /tmp

# Install WebMO. Read README.md to use secrets with Buildkit correctly
RUN --mount=type=secret,id=webmoinfo,dst=/secret/webmoinfo \
    cd /tmp/; \
    tar xvf sitc.tar.gz -C /opt/ && \
    /opt/sitc/install --webmo-license="$(awk 'NR==1' /secret/webmoinfo)" --webmo-password="$(awk 'NR==2' /secret/webmoinfo)" --yes-to-prompts --yes-to-sanity-check

# Cleaning
RUN rm -rf /tmp/sitc.tar.gz

EXPOSE 80
CMD ["/usr/sbin/apachectl","-DFOREGROUND"]
