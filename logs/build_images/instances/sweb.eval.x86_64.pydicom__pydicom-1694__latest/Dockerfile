FROM --platform=linux/x86_64 sweb.env.x86_64.6cf8a599aa20403f2c6e0a:latest

COPY ./setup_repo.sh /root/
RUN /bin/bash /root/setup_repo.sh

WORKDIR /testbed/
