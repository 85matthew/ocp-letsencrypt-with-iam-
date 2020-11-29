FROM amazon/aws-cli:latest

# Home directories required by acme.sh script.
ENV OCP_TOOLS_VERSION=4.6
ENV ACME_VERSION=2.8.6

#WORKDIR /scripts

# OpenSSL, curl and socat required for script.
RUN yum makecache && \
    yum install -y \
    shadow-utils  tar jq gzip openssl socat curl \
    && yum clean all && rm -rf /var/cache/dnf/*

WORKDIR /download

RUN curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$OCP_TOOLS_VERSION/openshift-client-linux.tar.gz | tar -xz && \
    mv oc /usr/bin/oc && \
    mv kubectl /usr/bin/kubectl

WORKDIR /source

RUN curl -L https://github.com/acmesh-official/acme.sh/archive/$ACME_VERSION.tar.gz | tar -xz

COPY scripts/aws.sh /scripts/aws.sh

RUN mkdir -p /tmp/.aws/cli/cache && touch /tmp/.aws/credentials && touch /tmp/.aws/config && chmod -R a+rwx /tmp/.aws

WORKDIR /tmp

