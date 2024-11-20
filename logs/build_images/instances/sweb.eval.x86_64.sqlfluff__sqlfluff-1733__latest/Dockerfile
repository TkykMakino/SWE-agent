FROM --platform=linux/x86_64 sweb.env.x86_64.7bdad884eed20022a88011:latest

COPY ./setup_repo.sh /root/
RUN /bin/bash /root/setup_repo.sh

WORKDIR /testbed/
