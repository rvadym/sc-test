FROM phpdockerio/php71-fpm:latest

RUN apt-get update && apt-get install --no-install-recommends -y \
		sqlite3 \
		git \
		htop \
		man \
		unzip \
		vim \
		wget \
		cron \
		sudo

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php-xdebug \
    php-memcached  \
    php7.1-mysql  \
    php-redis  \
    php7.1-sqlite3  \
    php7.1-bcmath  \
    php7.1-bz2  \
    php7.1-dba  \
    php7.1-gd  \
    php7.1-gmp  \
    php-imagick  \
    php7.1-intl  \
    php7.1-mbstring  \
    php-yaml  && \


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

# Allow mounting files
VOLUME ["/root"]
