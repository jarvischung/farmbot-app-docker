#!/bin/bash
set -e

nohup /sbin/entrypoint.sh > /postgresql.log 2>&1 &
echo "Start Postgresql service..."
sleep 40

if [ ! -d "/init_finish" ]; then
   sudo -u postgres psql -c "CREATE USER farmbot WITH PASSWORD 'farmbot1234'; ALTER USER farmbot WITH SUPERUSER;"
fi

if [ ! -d "/init_finish" ]; then
cd /Farmbot-Web-App && \
   rake db:create:all db:migrate db:seed
fi

echo "init" > /init_finish

cd /Farmbot-Web-App && \
   rails api:start	
