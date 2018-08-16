#Dockerfile for benchmark-tools

FROM centos
MAINTAINER Sangki Cho
RUN mkdir -p /usr/java
ADD ./openjdk-1.8.0_131 /usr/java/openjdk-1.8.0_131
ADD ./benchmark-tools /root/benchmark-tools
ADD ./start.sh /root/start.sh
RUN ln -s /usr/java/openjdk-1.8.0_131 /usr/java/jre8
ENV HOME /root
USER root
WORKDIR /root
CMD ["daemon"]
ENTRYPOINT ["/bin/bash","/root/start.sh"]
