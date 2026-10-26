FROM php:8.3.30-apache-bookworm

RUN docker-php-ext-install mysqli \
    && a2dissite 000-default \
    && sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
    && sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf \
    && sed -i 's#DocumentRoot /var/www/html#DocumentRoot /var/www/html#' /etc/apache2/sites-available/000-default.conf \
    && a2ensite 000-default \
    && sed -i 's#ErrorLog ${APACHE_LOG_DIR}/error.log#ErrorLog /dev/stderr#; s#CustomLog ${APACHE_LOG_DIR}/access.log combined#CustomLog /dev/stdout combined#' /etc/apache2/sites-available/000-default.conf \
    && mkdir -p /var/run/apache2 /var/lock/apache2 /var/log/apache2 \
    && chown -R www-data:www-data /var/run/apache2 /var/lock/apache2 /var/log/apache2 /var/www/html

COPY --chown=www-data:www-data . /var/www/html/

USER www-data

EXPOSE 8080

CMD ["apache2-foreground"]
