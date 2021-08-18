#!/bin/sh

export COMPOSE_FILE_PATH="${PWD}/target/classes/docker/docker-compose.yml"

if [ -z "${M2_HOME}" ]; then
  export MVN_EXEC="mvn"
else
  export MVN_EXEC="${M2_HOME}/bin/mvn"
fi

start() {
    docker volume create dpto_alfresco-acs-volume
    docker volume create dpto_alfresco-db-volume
    docker volume create dpto_alfresco-ass-volume
    docker-compose -f "$COMPOSE_FILE_PATH" up --build -d
}

start_share() {
    docker-compose -f "$COMPOSE_FILE_PATH" up --build -d dpto_alfresco-share
}

start_acs() {
    docker-compose -f "$COMPOSE_FILE_PATH" up --build -d dpto_alfresco-acs
}

down() {
    if [ -f "$COMPOSE_FILE_PATH" ]; then
        docker-compose -f "$COMPOSE_FILE_PATH" down
    fi
}

purge() {
    docker volume rm -f dpto_alfresco-acs-volume
    docker volume rm -f dpto_alfresco-db-volume
    docker volume rm -f dpto_alfresco-ass-volume
}

build() {
    $MVN_EXEC clean package
}

build_share() {
    docker-compose -f "$COMPOSE_FILE_PATH" kill dpto_alfresco-share
    yes | docker-compose -f "$COMPOSE_FILE_PATH" rm -f dpto_alfresco-share
    $MVN_EXEC clean package -pl dpto_alfresco-share,dpto_alfresco-share-docker
}

build_acs() {
    docker-compose -f "$COMPOSE_FILE_PATH" kill dpto_alfresco-acs
    yes | docker-compose -f "$COMPOSE_FILE_PATH" rm -f dpto_alfresco-acs
    $MVN_EXEC clean package -pl dpto_alfresco-integration-tests,dpto_alfresco-platform,dpto_alfresco-platform-docker
}

tail() {
    docker-compose -f "$COMPOSE_FILE_PATH" logs -f
}

tail_all() {
    docker-compose -f "$COMPOSE_FILE_PATH" logs --tail="all"
}

prepare_test() {
    $MVN_EXEC verify -DskipTests=true -pl dpto_alfresco-platform,dpto_alfresco-integration-tests,dpto_alfresco-platform-docker
}

test() {
    $MVN_EXEC verify -pl dpto_alfresco-platform,dpto_alfresco-integration-tests
}

case "$1" in
  build_start)
    down
    build
    start
    tail
    ;;
  build_start_it_supported)
    down
    build
    prepare_test
    start
    tail
    ;;
  start)
    start
    tail
    ;;
  stop)
    down
    ;;
  purge)
    down
    purge
    ;;
  tail)
    tail
    ;;
  reload_share)
    build_share
    start_share
    tail
    ;;
  reload_acs)
    build_acs
    start_acs
    tail
    ;;
  build_test)
    down
    build
    prepare_test
    start
    test
    tail_all
    down
    ;;
  test)
    test
    ;;
  *)
    echo "Usage: $0 {build_start|build_start_it_supported|start|stop|purge|tail|reload_share|reload_acs|build_test|test}"
esac