# https://www.ansible.com/
#
#################### Usage ###########################
# docker run --rm \
# 	-it \
# 	-v ${PWD}/hosts:/etc/ansible/hosts \
# 	-v ${PWD}/ansible.cfg:/etc/ansible/ansible.cfg \
# 	-v ${HOME}/.ssh:/root/.ssh:ro \
# 	ansible:latest ansible  all -m ping
#################### Build ############################
# ANSIBLE_BUILD_VERSION=2.9.8; docker build --build-arg ANS_VER=$ANSIBLE_BUILD_VERSION  -t storager/ansible:$ANSIBLE_BUILD_VERSION .
#######################################################
FROM alpine:latest
ARG ANS_VER 7.0.0
RUN builddeps=' \
		python3-dev \
		py3-pip \
		musl-dev \
		openssl-dev \
		libffi-dev \
		gcc \
		' \
	&& apk --no-cache add \
	ca-certificates \
	python3 \
	py3-paramiko \
	py3-yaml \
	py3-jinja2 \
	py3-httplib2 \
	$builddeps
RUN	pip install --upgrade pip \
	&& pip install \
		ansible==$ANS_VER \
		six
RUN apk del --purge $builddeps

#ENTRYPOINT [ "ansible" ]
