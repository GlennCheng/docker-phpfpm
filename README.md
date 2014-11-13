PFP-FPM with Docker
=============

## Introduction

This image contain only **PHP-FPM**, it need an Web server like [Apache](http://httpd.apache.org/) or [Nginx](http://nginx.org/) to run.

This image contains a lot of extensions:

* mysql
* apc
* imagick
* imap
* mcrypt
* curl
* cli
* gd
* pgsql
* sqlite
* json

## How to use this image

Pull the image from Docker Hub

```bash
docker pull stan/php-fpm
```

Start a php-fpm instance

```bash
docker run -d --name php54 stan/php-fpm
```

Start a php-fpm instance and bind a volume to /var/www

```bash
docker run -d --name php54 -v /your/path/on/host:/var/www stan/php-fpm
```

Start a web server (nginx) with this image as CGI.
This example use the image [**stan/nginx-phpfpm**](https://registry.hub.docker.com/u/stan/nginx-phpfpm/)

```bash
docker run -d --name php54 -v /your/php/project:/var/www stan/php-fpm
docker run -d --name nginx -p 80:80 --link php54:phpfpm -v /your/php/project:/var/www stan/nginx-phpfpm 
```

these commands launch a container with nginx and another with PHP-FPM. After that, you can visit the website with the IP of your host (the host's port is bind with nginx container).

## Feedback

### Issues

If you have any problems with or questions about this image, please contact us through an [issue](https://github.com/tsunammis/docker-phpfpm/issues).

### Contributing

You are invited to contribute new features, fixes or updates, large or small,  we are always trilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through an [issue](https://github.com/tsunammis/docker-phpfpm/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

