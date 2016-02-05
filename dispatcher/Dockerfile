FROM debian:jessie
MAINTAINER Dominik Foerderreuther <df@adobe.com>

# Install Apache
RUN apt-get update
RUN apt-get install apache2 curl wget -y


ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN wget https://www.adobeaemcloud.com/content/companies/public/adobe/dispatcher/dispatcher/_jcr_content/top/download_10/file.res/dispatcher-apache2.4-linux-x86-64-4.1.11.tar.gz

RUN mkdir mkdir -p dispatcher
RUN tar -xzf dispatcher-apache2.4-linux-x86-64-4.1.11.tar.gz
RUN rm dispatcher-apache2.4-linux-x86-64-4.1.11.tar.gz

RUN mkdir /etc/apache2/dispatcher
RUN mv "dispatcher-apache2.4-4.1.11.so" "/etc/apache2/dispatcher/dispatcher-apache2.4-4.1.11.so"
RUN ln -s /etc/apache2/dispatcher/dispatcher-apache2.4-4.1.11.so /etc/apache2/dispatcher/mod_dispatcher.so

ADD conf/dispatcher.conf /etc/apache2/conf-available/dispatcher.conf
RUN ln -s /etc/apache2/conf-available/dispatcher.conf /etc/apache2/conf-enabled/dispatcher.conf
ADD conf/dispatcher.any /etc/apache2/dispatcher/dispatcher.any

ADD conf/dispatcher-vhost.conf /etc/apache2/sites-available/dispatcher-vhost.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf
RUN rm /var/www/html/index.html
RUN ln -s /etc/apache2/sites-available/dispatcher-vhost.conf /etc/apache2/sites-enabled/100-dispatcher.conf

RUN chown www-data /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
