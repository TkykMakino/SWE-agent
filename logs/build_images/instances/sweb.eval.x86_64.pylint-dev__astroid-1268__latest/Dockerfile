FROM --platform=linux/x86_64 sweb.env.x86_64.fe8326858e7fdc7d50d1e5:latest

COPY ./setup_repo.sh /root/
RUN /bin/bash /root/setup_repo.sh

WORKDIR /testbed/
