FROM golang:alpine
MAINTAINER "nitin.solna@gmail.com"

# Configure the Terraform version here
ENV TERRAFORM_VERSION=0.11.10

RUN apk add --update git bash openssh

# install azure cli
RUN apk update && \
apk add bash py-pip make && \
apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev
RUN pip install --upgrade pip
RUN pip install azure-cli
RUN apk del --purge build

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
git checkout v${TERRAFORM_VERSION} && \
/bin/bash scripts/build.sh

WORKDIR /root
