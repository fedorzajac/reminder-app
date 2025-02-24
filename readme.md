# how to run the project

```bash
git pull https://github.com/fedorzajac/reminder-app.git
cd reminder-app

# only if first time
docker-compose run --rm app rails db:create
docker-compose run --rm app rails db:migrate

docker-compose up
```
