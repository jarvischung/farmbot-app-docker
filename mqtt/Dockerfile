FROM rickcarlino/rmq_base:rc1
# TODO: Move this into base image on dockerhub

RUN apt-get update && apt-get install curl --yes

ADD ./rabbitmq.config /etc/rabbitmq/
ADD ./start.sh /
RUN chmod +x /start.sh
