FROM ubuntu:latest
ARG GEOGRAPHIC_AREA=Indian

# Set the time zone based on the selected geographic area
RUN ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo Asia/Kolkata > /etc/timezone

RUN apt-get update -y \
    && apt-get install -y nginx php8.1-fpm php-mysql wget \
    && rm /etc/nginx/sites-available/default

RUN apt install unzip -y

COPY default /etc/nginx/sites-available/default

WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz
RUN tar xzvf latest.tar.gz
RUN rm -r latest.tar.gz
WORKDIR /var/www/html/wordpress/
COPY . wp-config.php

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
CMD ["sh", "-c", "service php8.1-fpm restart"]
#RUN  service php8.1-fpm restart
#CMD ["nginx", "-g", "daemon off;","&&","service","php8.1-fpm" ,"restart"]


#CMD ["nginx", "-g", "daemon off;"]
