IMAGE_PREFIX = "sf-"
IMAGE_DIR = "./images"

.PHONY: all nginx php-fpm php-cli
default: all;   # default target

all: nginx php-fpm php-cli

nginx:
	docker build -t $(IMAGE_PREFIX)nginx $(IMAGE_DIR)/nginx

php-fpm:
	docker build -t $(IMAGE_PREFIX)php-fpm $(IMAGE_DIR)/php-fpm

php-cli:
	docker build -t $(IMAGE_PREFIX)php-cli $(IMAGE_DIR)/php-cli
