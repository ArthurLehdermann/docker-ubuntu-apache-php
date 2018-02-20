FROM ubuntu

ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV ACCEPT_EULA=Y
ENV TERM=xterm

RUN apt-get purge -y php*
RUN apt-get update && apt-get upgrade -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils apt-transport-https software-properties-common

RUN apt-get update && apt-get install -y curl git vim supervisor composer apache2

RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y \
        libapache2-mod-php7.1 \
        php7.1 \
        php7.1-cgi \
        php7.1-cli \
        php7.1-dev \
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
        php7.1-soap \
        php7.1-sqlite3 \
        php7.1-sybase \
        php7.1-tidy \
        php7.1-xml \
        php7.1-xmlrpc \
        php7.1-zip \
        php7.1-opcache \
        php-apcu \
	php-imagick \
        php-memcached \
        php-pear \
        php-redis \
        php-token-stream \
        phpunit \
        sendmail \
    && apt-get clean \
    && rm -fr /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y npm nodejs

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev 
#    libodbc1-utf16

#RUN apt-get update && apt-get install -y \
#    unixodbc-utf16 \
#    unixodbc-dev-utf16

#RUN apt-get update && apt-get install -y \
#    mssql-tools \
#    msodbcsql

#RUN pecl install sqlsrv
#RUN echo "extension=sqlsrv.so" >> /etc/php/7.0/apache2/php.ini
#RUN pecl install pdo_sqlsrv
#RUN echo "extension=pdo_sqlsrv.so" >> /etc/php/7.0/apache2/php.ini
#RUN echo "extension=/usr/lib/php/20151012/sqlsrv.so" >> /etc/php/7.0/apache2/php.ini
#RUN echo "extension=/usr/lib/php/20151012/pdo_sqlsrv.so" >> /etc/php/7.0/apache2/php.ini
#RUN echo "extension=/usr/lib/php/20151012/sqlsrv.so" >> /etc/php/7.0/cli/php.ini
#RUN echo "extension=/usr/lib/php/20151012/pdo_sqlsrv.so" >> /etc/php/7.0/cli/php.ini
#RUN ACCEPT_EULA=Y apt-get install -y msodbcsql
#RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
#RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
#
#RUN apt-get install -y locales && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

RUN a2enmod rewrite

COPY conf/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY conf/apache/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY conf/run.sh /run.sh

RUN chmod 755 /run.sh

COPY conf/config /config

WORKDIR /var/www/html

EXPOSE 80 80

CMD ["/run.sh"]
