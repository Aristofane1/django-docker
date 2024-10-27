#!/bin/sh
# pour vérifier que Postgres est sain avant d’appliquer les migrations et d’exécuter le serveur de développement Django


if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py flush --no-input
python manage.py migrate

exec "$@"