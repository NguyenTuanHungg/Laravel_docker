## Setup Laravel environment
```bash
cp .env.example .env

docker-compose up -d --build
docker-compose exec laravel sh
composer install
php artisan key:generate