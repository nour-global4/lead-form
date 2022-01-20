# lead-form

## Project setup
```
docker-compose up -d
docker-compose run --rm npm install
```

### For development
````
cp .env.example .env
docker-compose run --rm npm run serve
````

### On production
````
docker-compose run --rm npm run build
docker-compose down
docker-compose up -d
````
