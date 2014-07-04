FROM stackbrew/debian:wheezy

MAINTAINER Stan Chollet <stanislas.chollet@gmail.com>

# Install PHP FPM
RUN apt-get update
RUN apt-get -y -f install php5-fpm php5-mysql php-apc php5-imagick php5-imap php5-mcrypt php5-curl php5-cli php5-gd php5-pgsql php5-sqlite php5-common curl php5-json

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# FPM
RUN sed -i 's|listen = /var/run/php5-fpm.sock|listen = 9000|g' /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's|;cgi.fix_pathinfo=0|cgi.fix_pathinfo=0|g' /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's|;daemonize = yes|daemonize = no|g' /etc/php5/fpm/php-fpm.conf

# PHP (FPM)
RUN sed -i 's|;date.timezone =|date.timezone = "Europe/Paris"|g' /etc/php5/fpm/php.ini
RUN sed -i 's|memory_limit = 128M|memory_limit = 256M|g' /etc/php5/fpm/php.ini

# PHP (CLI)
RUN sed -i 's|;date.timezone =|date.timezone = "Europe/Paris"|g' /etc/php5/cli/php.ini
RUN sed -i 's|memory_limit = 128M|memory_limit = 256M|g' /etc/php5/cli/php.ini

# PHP Welcome page
RUN mkdir /var/www
RUN touch /var/www/index.php
RUN echo '<?php $w = "Steve"; echo "Welcome $w"; ?>' > /var/www/index.php
RUN chown -R www-data:www-data -R /var/www
RUN chmod 755 /var/www
RUN chmod 644 /var/www/index.php 

# Setup file
ADD setup.sh /root/setup.sh
RUN chmod +x /root/setup.sh

# Clear
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose PHP-FPM port
EXPOSE 9000

# CMD /bin/bash /root/setup.sh && php5-fpm -R
CMD /bin/bash /root/setup.sh && service php5-fpm start
