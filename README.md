![Docker Pulls](https://img.shields.io/docker/pulls/kaneymhf/docker-laravel-snmp) [![](https://images.microbadger.com/badges/image/kaneymhf/docker-laravel-snmp.svg)](https://microbadger.com/images/kaneymhf/docker-laravel-snmp "Get your own image badge on microbadger.com") ![Docker Stars](https://img.shields.io/docker/stars/kaneymhf/docker-laravel-snmp) [![](https://images.microbadger.com/badges/version/kaneymhf/docker-laravel-snmp.svg)](https://microbadger.com/images/kaneymhf/docker-laravel-snmp "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/license/kaneymhf/docker-laravel-snmp.svg)](https://microbadger.com/images/kaneymhf/docker-laravel-snmp "Get your own license badge on microbadger.com")

# Docker Laravel

This images contains an instance of apache 2.4 and php 7.3 on port 80, based on CentOS 7 Linux, with all the requeriments to run Laravel 6.x and php snmp extension

# Docker Informations

* This image expose the following port

| Port | Usage |
|:----:|:-----:|
|  80/tcp  | HTTP Web application |
|  443/tcp  | HTTPS Web application |

* This image takes theses environnements variables as parameters

|  Environment |       Type       | Default |                        Usage                        |
|:------------:|:----------------:|:-------:|:---------------------------------------------------:|
|    APPLICATION   |      String      | application |                Set the application name               |
| INSTALLED | Boolean<br>(0/1) |    0    | Set to 1 if application is already installed |

The *INSTALLED* enviroment sets Laravel corrects permissions to all folders and files, if not setted all system will be 775 permissions.

* The following volume is exposed by this image

|         Volume        |          Usage          |
|:---------------------:|:-----------------------:|
|  /var/www/$APPLICATION/html  |  The html folder  |

# Usage

## Docker-compose Specific configuration examples

```yml
version: "3.2"

services:
#PostgreSQL Container
  mysql:
    image: postgres:12
    container_name: postgres
    hostname: postgres
    environment:
     - POSTGRES_USER=application
     - POSTGRES_PASSWORD=application
     - POSTGRES_DB=application
     - PGDATA=/var/lib/postgresql/data/pgdata
     - TZ=GMT-3
    volumes:
    - /path/to/data:/var/lib/postgresql/data/pgdata

#Application Container
  application:
    image: kaneymhf/docker-laravel-snmp
    container_name : webadmin
    hostname: webadmin
    ports:
      - "80:80"
      - "443:443"
    environment:
      - TZ=Etc/GMT+3
      - APPLICATION=application
    volumes:
      - /path/to/html:/var/www/html/application/files
```