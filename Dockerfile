FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql


# Install PHP modules and enable Apache modules
RUN a2enmod php7.4
RUN a2enmod rewrite

# Expose ports (80 for Apache and 3306 for MySQL)
EXPOSE 80
EXPOSE 3306

# Start services when the container is run
CMD service apache2 start && service mysql start && tail -f /var/log/apache2/access.log
