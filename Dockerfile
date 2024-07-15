FROM php:8.1-fpm

WORKDIR /var/www

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        libonig-dev \
        libxml2-dev \
        vim \
        git \
        unzip \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Configure GD extension with FreeType and JPEG support
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install required PHP extensions
RUN docker-php-ext-install pdo_pgsql mbstring exif pcntl bcmath gd zip xml

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Permission
RUN chown www:www /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]