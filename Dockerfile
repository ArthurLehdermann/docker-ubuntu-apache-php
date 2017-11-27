FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
		apache2 \
		software-properties-common \
		supervisor \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

ENV LC_ALL=C.UTF-8
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y --no-install-recommends \
		libapache2-mod-php7.1 \
		php7.1 \
        php7.1-cgi \
        php7.1-cli \
        php7.1-dev \
        php7.1-fpm \
        php7.1-phpdbg \
        php7.1-bcmath \
        php7.1-bz2 \
        php7.1-common \
        php7.1-curl \
        php7.1-dba \
        php7.1-enchant \
        php7.1-gd \
        php7.1-gmp \
        php7.1-imap \
        php7.1-interbase \
        php7.1-intl \
        php7.1-json \
        php7.1-ldap \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-odbc \
        php7.1-pgsql \
        php7.1-pspell \
        php7.1-readline \
        php7.1-recode \
        php7.1-snmp \
        php7.1-soap \
        php7.1-sqlite3 \
        php7.1-sybase \
        php7.1-tidy \
        php7.1-xml \
        php7.1-xmlrpc \
        php7.1-zip \
        php7.1-opcache \
		php-token-stream \
		phpunit \
		php-apcu \
		php-memcached \
		php-pear \
		php-redis \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

RUN a2enmod rewrite

COPY conf/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY conf/apache/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY conf/run.sh /run.sh

RUN chmod 755 /run.sh

COPY conf/config /config

EXPOSE 80

CMD ["/run.sh"]
