FROM phpdockerio/php72-fpm:latest

RUN apt-get update && apt-get install --no-install-recommends -y \
		sqlite3 \
		git \
		htop \
		man \
		unzip \
		vim \
		wget \
		cron \
		ssh \
		imagemagick \
		sudo

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php-xdebug \
    php-memcached  \
    php7.2-mysql  \
    php-redis  \
    php7.2-sqlite3  \
    php7.2-bcmath  \
    php7.2-bz2  \
    php7.2-dba  \
    php7.2-gd  \
    php7.2-gmp  \
    php-imagick  \
    php7.2-intl  \
    php7.2-mbstring  \
    php-yaml \
    build-essential && \


    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
    apt-get update -y && apt-get install -y \
        nodejs && \

    npm install elasticdump -g && \
    npm install bower -g && \
    npm install less -g

# Tidy up
RUN apt-get -y autoremove && apt-get clean && apt-get autoclean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN mkdir -m 777 /var/tmp/project && mkdir -m 777 /var/tmp/project/vendor && mkdir -m 777 /var/tmp/project/cache && mkdir -m 777 /var/tmp/project/logs

# Install composer
RUN curl https://getcomposer.org/installer | php -- && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN composer global require --optimize-autoloader "hirak/prestissimo"

# Allow mounting files
VOLUME ["/root"]
