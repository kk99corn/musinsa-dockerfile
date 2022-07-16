FROM ubuntu:20.04
LABEL maintainer="hahahoho5915 <hahahoho5915@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get -y install \
	git \
	vim \
	apache2 \
	php7.4 \
	php7.4-common \
	php7.4-mysql \
	php7.4-mbstring \
	php7.4-curl \
	php7.4-xml \
	php7.4-intl \
	php7.4-sqlite3

RUN mkdir /home/web \
	&& cd /home/web \
	&& git clone https://github.com/kk99corn/musinsa-api.git \
	&& chmod 777 -R /home/web/musinsa-api/writable

RUN cd /etc/apache2/sites-available \
	&& rm -f 000-default.conf \
	&& cd /etc/apache2/sites-enabled \
	&& rm -f 000-default.conf
	
ADD ./settings/000-default.conf /etc/apache2/sites-available
RUN ln -s /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite

EXPOSE 80

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
