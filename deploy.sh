#!/bin/bash

if [ -f .deploy-config ]; then
  export $(grep -v '^#' .deploy-config | xargs)
else
  echo "Отсутствует .deploy-config"
  exit 1
fi

# Фронт
FRONTEND_DIR="frontend"
FRONTEND_GITHUB_URL="https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/$FRONTEND_GITHUB_REPOSITORY.git"

if [ -d "$FRONTEND_DIR" ]; then
  rm -rf "$FRONTEND_DIR"
fi

git clone --branch main "$FRONTEND_GITHUB_URL" "$FRONTEND_DIR"
if [ $? -ne 0 ]; then
    echo "Ошибка clone для frontend"
    exit 1
fi

# Бэк
echo "Docker hub login"
echo $BACKEND_DOCKER_TOKEN | docker login -u $BACKEND_DOCKER_USERNAME --password-stdin
if [ $? -ne 0 ]; then
  echo "Ошибка Docker hub login"
  exit 1
fi

docker compose -f docker-compose.yml -p trainer up -d --build
if [ $? -ne 0 ]; then
  echo "Ошибка docker compose"
  exit 1
fi
echo "Успешно"
