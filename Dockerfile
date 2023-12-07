ROM ubuntu:latest
ARG GEOGRAPHIC_AREA=Indian

# Set the time zone based on the selected geographic area
RUN ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo Asia/Kolkata > /etc/timezone
#RUN apt get install -y software-properties-common
#RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && \
   apt-get install -y nginx php8.1-fpm php-mysql wget  && \
    apt-get install -y php-mysqli

RUN apt update

#RUN apt install php-fpm
RUN apt install unzip -y
RUN rm /etc/nginx/sites-available/default
COPY default /etc/nginx/sites-available/default

WORKDIR /var/www/html/
RUN wget https://wordpress.org/latest.tar.gz && \
    tar xzvf latest.tar.gz && \
    rm -r latest.tar.gz
WORKDIR /var/www/html/wordpress/
COPY wp-config.php .

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /etc/php/8.1/fpm/pool.d
RUN find . -type f -exec sed -i 's#/run/php/php8.1-fpm.sock#/var/run/php/php8.1-fpm.sock#g' {} +

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
    


#----------------------------------------------------------------------------------------------------------------------------

# FROM ubuntu:latest
# ARG GEOGRAPHIC_AREA=Indian

# # Set the time zone based on the selected geographic area
# RUN ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo Asia/Kolkata > /etc/timezone

# RUN apt-get update -y \
#     && apt-get install -y nginx php8.1-fpm php-mysql wget \
#     && rm /etc/nginx/sites-available/default

# RUN apt install unzip -y

# COPY default /etc/nginx/sites-available/default

# WORKDIR /var/www/html
# RUN wget https://wordpress.org/latest.tar.gz
# RUN tar xzvf latest.tar.gz
# RUN rm -r latest.tar.gz
# WORKDIR /var/www/html/wordpress/
# COPY . wp-config.php

# RUN chown -R www-data:www-data /var/www/html \
#     && chmod -R 755 /var/www/html

# EXPOSE 80
# CMD ["sh", "-c", "service php8.1-fpm restart"]
    #RUN  service php8.1-fpm restart
    #CMD ["nginx", "-g", "daemon off;","&&","service","php8.1-fpm" ,"restart"]


#CMD ["nginx", "-g", "daemon off;"]

#---------------------------------------------------------------------------------------------------------------------



# FROM ubuntu:latest
# ARG GEOGRAPHIC_AREA=Indian

# # Set the time zone based on the selected geographic area
# RUN ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo Asia/Kolkata > /etc/timezone

# RUN apt-get update && \
#    apt-get install -y nginx php8.1-fpm php-mysql wget  && \
#     apt-get install -y php-mysqli

# RUN apt-get install -y software-properties-common


# RUN add-apt-repository ppa:ondrej/php
# RUN apt update

# #RUN apt install php-fpm
# RUN apt install unzip -y
# RUN rm /etc/nginx/sites-available/default
# COPY default /etc/nginx/sites-available/default
# WORKDIR /var/www/html/
# RUN wget https://wordpress.org/latest.tar.gz && \
#     tar xzvf latest.tar.gz && \
#     rm -r latest.tar.gz

# WORKDIR /var/www/html/wordpress/
# COPY wp-config.php .

# RUN chown -R www-data:www-data /var/www/html && \
#     chmod -R 755 /var/www/html

# WORKDIR /etc/php/8.1/fpm/pool.d
# RUN find . -type f -exec sed -i 's#/run/php/php8.1-fpm.sock#/var/run/php/php8.1-fpm.sock#g' {} +

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]

