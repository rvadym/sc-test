FROM phpdockerio/php56-fpm:latest
MAINTAINER SC-test

RUN apt-get update && apt-get install --no-install-recommends -y \
		sqlite3 \
		git \
		htop \
		man \
		unzip \
		vim \
		wget \
		sudo

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        php5-dev \
        php5-xdebug \
        php5-apcu \
        php5-json \
        php5-memcached \
        php5-memcache \
        php5-mysql \
        #php5-pgsql \
        #php5-mongo \
        php5-sqlite \
        php5-sybase \
        php5-interbase \
        php5-odbc \
        php5-gearman \
        php5-mcrypt  \
        php5-ldap \
        php5-gmp  \
        php5-intl \
        php5-geoip \
        php5-imagick \
        php5-gd \
        php5-imap \
        php5-curl \
        php5-oauth \
        php5-redis \
        #php5-ps \
        php5-enchant \
        php5-xsl \
        php5-xmlrpc \
        php5-tidy \
        php5-recode \
        php5-readline \
        php5-pspell \
        php-pear && \

    # Check PHP version
    php --version && \
    php -m && \

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

EXPOSE 9000
