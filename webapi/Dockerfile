FROM ruby:2.4.2

RUN apt-get update
RUN apt-get install -y apt-transport-https sudo

# Install Postgresql
ENV PG_APP_HOME="/etc/docker-postgresql"\
    PG_VERSION=9.6 \
    PG_USER=postgres \
    PG_HOME=/var/lib/postgresql \
    PG_RUNDIR=/run/postgresql \
    PG_LOGDIR=/var/log/postgresql \
    PG_CERTDIR=/etc/postgresql/certs

ENV PG_BINDIR=/usr/lib/postgresql/${PG_VERSION}/bin \
    PG_DATADIR=${PG_HOME}/${PG_VERSION}/main

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y acl \
      postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} \
 && ln -sf ${PG_DATADIR}/postgresql.conf /etc/postgresql/${PG_VERSION}/main/postgresql.conf \
 && ln -sf ${PG_DATADIR}/pg_hba.conf /etc/postgresql/${PG_VERSION}/main/pg_hba.conf \
 && ln -sf ${PG_DATADIR}/pg_ident.conf /etc/postgresql/${PG_VERSION}/main/pg_ident.conf \
 && rm -rf ${PG_HOME} \
 && rm -rf /var/lib/apt/lists/*

COPY postgresql/runtime/ ${PG_APP_HOME}/
COPY postgresql/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 5432/tcp
#VOLUME ["${PG_HOME}", "${PG_RUNDIR}"]
#WORKDIR ${PG_HOME}
#ENTRYPOINT ["/sbin/entrypoint.sh"]

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash 
RUN apt-get install -y nodejs --yes

RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib libpq-dev curl bash git jq imagemagick yarn gcc make zlib1g-dev sqlite3 g++ libpq-dev postgresql-contrib \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install FarmBot Web App
RUN git clone https://github.com/FarmBot/Farmbot-Web-App --depth=10
RUN cd Farmbot-Web-App \
  && gem install bundler \
  && npm install yarn \
  && bundle install \
  && yarn install
ADD database.yml /Farmbot-Web-App/config/
ADD application.yml /Farmbot-Web-App/config/

ADD start.sh /start.sh
RUN chmod +x /start.sh

