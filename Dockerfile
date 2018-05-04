FROM ros:kinetic-ros-core-xenial

RUN apt-get update && apt-get install -y -q sudo \
  wget

ADD cmd.sh /
RUN chmod +x /cmd.sh

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENV ROSCORE_PORT 5000
CMD ["/cmd.sh"]
ENTRYPOINT ["/entrypoint.sh"]
