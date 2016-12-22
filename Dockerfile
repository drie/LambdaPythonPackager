FROM drie/lambdalike:latest

ADD package /usr/local/bin
RUN chmod u+x /usr/local/bin/package

WORKDIR /home/ec2-user
USER ec2-user
