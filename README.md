# farmbot-docker

## Please check and modify docker-compose.yml before execute them. ##
```docker
# For fapi
environment:
    - HOSTIP=jarvis3f.myqnapcloud.com  #Farmbot web-app
    - PGHOST=localhost  #Postgresql server address. we include this server in fapi.
    - PGPORT=5432 #Postgresql server port
    - PGUSER=farmbot #Postgresql user account
    - PGPASS=farmbot1234 #Postgresql user password
    - PGDBNAME=farmbot #Postgresql DB name
    - WSPORT=15675 #if not use host mode, please setup this port to 3002
....
# For mqtt
environment:
    - APIHOST=jarvis3f.myqnapcloud.com
    - APIPORT=3000
    - PKAPIURL=http://jarvis3f.myqnapcloud.com:3000/api/public_key
    - VHOST=/

```

## How to use docker-compose
```
# docker-compose build
# docker-compose up
```