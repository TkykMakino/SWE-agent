FROM --platform=linux/x86_64 sweb.env.x86_64.1cf2a749a12b4261fa2fc2:latest

COPY ./setup_repo.sh /root/
RUN /bin/bash /root/setup_repo.sh

WORKDIR /testbed/
