docker-symfony
==============

Docker development environment for Symfony Flex projects.

# Requirements

- Recent versions of docker and docker-compose
- An existing symfony installation
```sh
docker run -it --rm -v $(pwd):/app composer:latest composer create-project symfony/skeleton .
```


# Installation

- Clone the repository
```sh
git clone git@github.com:graillus/docker-symfony.git
cd docker-symfony
```

- Copy all files to target project root
```sh
cp -R * .* /path/to/project
```

# Usage

In your project root directory, just build and lauch the containers:
```sh
docker-compose build
docker-compose up -d
```

# XDebug

If you want to use xdebug remote debugging, you need to configure the xdebug remote host.

```yaml
    php-fpm:
      ...
      environment:
        XDEBUG_CONFIG: remote_host=172.20.0.1 # IP shown in the symfony profiler
```

Now configure your IDE with the following parameters:
- IDE key: idekey
- host: localhost
- port: 9000
- debugger: Xdebug

Map your local project directory to `/var/www/app` on the remote host.

Restart the containers and start listening for debug connections.

# License

WTFPL v2

![WTFPL v2](http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-1.png)

See the LICENSE file.
