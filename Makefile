nginx:
	docker build -t sf-nginx ./nginx

php-fpm:
	docker build -t sf-php-fpm ./php-fpm

php-cli:
	docker build -t sf-php-cli ./php-cli
