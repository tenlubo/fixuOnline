#!/bin/sh

COMPOSE_FILE_PATH_ALF="${PWD}/templateInstance/template-docker-compose.yml"

COMPOSE_FILE_PATH_COMMONS="${PWD}/commons/commons-docker-compose.yml"

prop() {
    grep "${1}" env/"${2}".env|cut -d'=' -f2
}

createVolumes() {
    if [ -n "$1" ]; then
      PROJECT_NAME=$(prop "ALF_PROJECT_NAME" "$1")
      docker volume create bikes-acs-"${PROJECT_NAME}"-volume
      docker volume create bikes-ass-"${PROJECT_NAME}"-volume
      docker volume create bikes-log-"${PROJECT_NAME}"-volume
    else
      docker volume create ldap-data-volume
      docker volume create ldap-config-volume
      docker volume create maria-data-volume
      docker volume create maria-log-volume
    fi
}

doDockerComposeUp() {
    if [ -z "$1" ]; then
      docker-compose -f "$COMPOSE_FILE_PATH_COMMONS" --env-file ./commons/commons.env --project-name alfresco_commons up -d
    else
      PROJECT_NAME=$(prop "ALF_PROJECT_NAME" "$1")
      docker-compose -f "$COMPOSE_FILE_PATH_ALF" --env-file env/"$1".env --project-name "${PROJECT_NAME}" up -d
    fi
}

doDockerCompose() {
    if [ -z "$2" ]; then
      docker-compose -f "$COMPOSE_FILE_PATH_COMMONS" --env-file ./commons/commons.env --project-name alfresco_commons "$1"
    else
      PROJECT_NAME=$(prop "ALF_PROJECT_NAME" "$2")
      docker-compose -f "$COMPOSE_FILE_PATH_ALF" --env-file env/"$2".env --project-name "${PROJECT_NAME}" "$1"
    fi
}

purge() {
    if [ -z "$1" ]; then
      docker volume rm -f ldap-data-volume
      docker volume rm -f ldap-config-volume
      docker volume rm -f maria-data-volume
      docker volume rm -f maria-log-volume
      docker volume prune
    else
      PROJECT_NAME=$(prop "ALF_PROJECT_NAME" "$1")
      docker volume rm -f bikes-acs-"${PROJECT_NAME}"-volume
      docker volume rm -f bikes-ass-"${PROJECT_NAME}"-volume
      docker volume rm -f bikes-log-"${PROJECT_NAME}"-volume
    fi
}

tail() {
    if [ -z "$1" ]; then
      docker-compose -f "$COMPOSE_FILE_PATH_COMMONS" logs -f
    else
      PROJECT_NAME=$(prop "ALF_PROJECT_NAME" "$1")
      docker-compose -f "$COMPOSE_FILE_PATH_ALF" --env-file env/"$1".env --project-name "${PROJECT_NAME}" logs -f
    fi
}

case "$1" in
  up_log)
    createVolumes "$2"
    doDockerComposeUp "$2"
    tail "$2"
    ;;
  up)
    createVolumes "$2"
    doDockerComposeUp "$2"
    ;;
  down)
    doDockerCompose "down" "$2"
    ;;
  purge)
    doDockerCompose "down" "$2"
    purge "$2"
    ;;
  *)
    echo "Usage: $0 {up_log|up|down|purge} [env-file-name]"
esac
