#!/bin/sh

getComposeFileFromServiceName() {
  echo "${PWD}/$1/docker-compose.yml"
}

doDockerComposeUp() {
  SERVICE_DOCKER_FILE_NAME=$(getComposeFileFromServiceName "$1")
  docker-compose -f "$SERVICE_DOCKER_FILE_NAME" --project-name "$1" --env-file "$1"/.env up -d
}

doDockerCompose() {
  SERVICE_DOCKER_FILE_NAME=$(getComposeFileFromServiceName "$2")
  docker-compose -f "$SERVICE_DOCKER_FILE_NAME" --project-name "$2" --env-file "$2"/.env "$1"
}

case "$1" in
up)
  doDockerComposeUp "$2"
  ;;
down)
  doDockerCompose "down" "$2"
  ;;

*)
  echo "Usage: $0 {up|down} {ldap|kibana|beats|acti|aps}"
  ;;
esac
