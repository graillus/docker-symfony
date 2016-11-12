docker-symfony
==============

Docker images for standard Symfony projects.

* nginx
* php-fpm
* php-cli (with composer)

# Requirements

You need recent versions of docker and docker-compose

# Installation

- Clone the repository
```sh
git clone git@github.com:graillus/docker-symfony.git
cd docker-symfony
```

- Build images
```sh
make
```

- Test installation
```sh
docker-compose up -d
```
```sh
curl http://localhost/index.html
<!DOCTYPE html>
<html>
	<head>
		<title>Welcome</title>
	</head>
<body>It works !</body>
</html>
```


# Usage

Copy the docker-compose.yml file in your project root directory and cd into it:
```sh
cp docker-compose.yml /path/to/project/
cd /path/to/project/
```

Now mount your project files into a volume for nginx and php-fpm
```yaml
services:
    nginx:
        image: sf-nginx
        ports:
            - "80:80"
        volumes:
            - .:/var/www

    php-fpm:
        image: sf-php-fpm
        volumes:
            - .:/var/www
```

```sh
docker-compose up -d
```

# Symfony profiler

If you want to be able to access the profiler, you have to remove the security check in `web/app_dev.php`

# XDebug

If you want to use xdebug remote debugging, you need to configure the xdebug remote host.

```yaml
...
    php-fpm:
        image: sf-php-fpm
        volumes:
            - .:/var/www
        environment:
            XDEBUG_CONFIG: remote_host=172.20.0.1 # IP shown in the symfony profiler
```

Now configure your IDE with the following parameters:
- IDE key: IDEKEY
- host: localhost
- port: 9000
- debugger: Xdebug

Map your local project directory to `/var/www` on the remote host.

Restart the containers and start listening for debug connections.

# Misc

Use helper scripts to run common commands into the php-cli container
```sh
cp bin/* /path/to/project/bin
```

Now to run composer use
```sh
bin/composer <args>
```

Symfony console
```sh
bin/docker-console <args>
```
