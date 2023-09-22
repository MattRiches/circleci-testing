# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set non-interactive mode during installation
ARG DEBIAN_FRONTEND=noninteractive

# Update the package repository and install necessary software
RUN apt-get update && \
    apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql

# Configure MySQL root password (replace 'your_password' with a secure password)
RUN echo "mysql-server mysql-server/root_password password your_password" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password your_password" | debconf-set-selections

# Install PHP modules and enable Apache modules
RUN a2enmod php7.4
RUN a2enmod rewrite

# Expose ports (80 for Apache and 3306 for MySQL)
EXPOSE 80
EXPOSE 3306

# Start services when the container is run
CMD service apache2 start && service mysql start && tail -f /var/log/apache2/access.log
