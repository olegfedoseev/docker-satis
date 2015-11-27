FROM php:5.6-apache
MAINTAINER Oleg Fedoseev <oleg.fedoseev@me.com>

RUN apt-get update && apt-get install -y git zlib1g-dev && apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	docker-php-ext-install zip && a2enmod rewrite && \
	echo "date.timezone = UTC" > /usr/local/etc/php/conf.d/timezone.ini && \
	echo "memory_limit = -1" > /usr/local/etc/php/conf.d/memory.ini

ENV COMPOSER_HOME /var/www/composer
RUN mkdir /var/www/composer && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	composer config -g cache-dir /var/www/composer/cache

RUN composer create-project playbloom/satisfy --stability=dev --no-dev /var/www/satisfy --no-interaction && \
	rm -rf /var/www/html && ln -s /var/www/satisfy/web /var/www/html

# pathed version with /build/ endpoint
ADD satisfy.php /var/www/satisfy/app/satisfy.php
ADD config.php /var/www/satisfy/app/config.php
ADD satis.json /var/www/satisfy/satis.json
ADD start.sh /bootstrap.sh

RUN mkdir /var/www/satisfy/web/dist && \
	/var/www/satisfy/bin/satis -n build /var/www/satisfy/satis.json /var/www/satisfy/web

RUN chown -R www-data:www-data /var/www/composer && \
	chown -R www-data:www-data /var/www/satisfy/app/data /var/www/satisfy/web/include /var/www/satisfy/web/dist/ && \
	chown www-data:www-data /var/www/satisfy/web/packages.json /var/www/satisfy/web/index.html /var/www/satisfy/satis.json

VOLUME ['/var/www/satisfy/web/dist', '/var/www/composer/cache']
CMD ["/bootstrap.sh"]
