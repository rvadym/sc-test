FROM ubuntu:14.04
MAINTAINER SC-test

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV TERM xterm

# Our user in the container
USER root
WORKDIR /root

# Need to generate our locale.
RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# ----------------------------------------------------------------------
#
#                           INSTALL SOFTWARE
#
# ----------------------------------------------------------------------

RUN \
    \
    # Enable PHP 5.6 repo
    echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-key E5267A6C && \

    # Install required software
    apt-get update && apt-get install --no-install-recommends -y \

        apache2 php5 \

		curl ca-certificates \

		sqlite3 \
		git \
		htop \
		man \
		unzip \
		vim \
		wget  \

		php5-cli \
		php5-dev \
		php5-xdebug \
		php5-apcu \
		php5-json \
		#php5-memcached \
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
		#php5-redis \
		php5-ps \
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

    # Install elastick dump
    npm install bower -g && \
    npm install less -g && \


    # Tidy up
    apt-get -y autoremove && apt-get clean && apt-get autoclean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

    # Install composer
    curl https://getcomposer.org/installer | php -- && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# INSTALL SOFTWARE ----------------------------------------------------------------------

COPY ["./files/000-default.conf", "/etc/apache2/sites-available/000-default.conf"]
RUN ln -s /app/web /var/www/app
RUN a2enmod rewrite

# Allow mounting files
VOLUME ["/root"]
VOLUME ["/app"]

CMD service apache2 start && /bin/bash

EXPOSE 80