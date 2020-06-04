#!/bin/bash

# store arguments in a special array 
args=("$@")

# Get environment variables
export $(grep -v '^#' .env | xargs -d '\n')

if [ "${args[0]}" = "up" ]; then
    docker_state=$(docker info >/dev/null 2>&1)
    if [[ $? -ne 0 ]]; then
        echo "Docker does not seem to be running, run it first and retry"
        exit 1
    fi

    docker-compose up -d 
 
    docker_state=$(docker ps --filter "name=jupyterhub" -q >/dev/null 2>&1)
    if [[ $? -ne 0 ]]; then
        echo "Wait 30s for MySQL to init database"
        sleep 30s;
    fi

    echo " " 
    echo " Dashboard    : http://${HOST}:8080 "
    echo " " 
    echo " MySQL:   mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mysql:3306/mlflow"
    echo " S3:      http://${S3_ENDPOINT_URL} ${S3_ACCESS_KEY_ID} ${S3_SECRET_ACCESS_KEY}"

    #echo "Removing helpers container"
    #docker rm $(docker ps -q -f status=exited)
 
elif [ "${args[0]}" = "restart" ]; then
    docker-compose restart
elif [ "${args[0]}" = "stop" ]; then
    docker-compose stop
elif [ "${args[0]}" = "down" ]; then
    docker-compose down
elif [ "${args[0]}" = "purge" ]; then
    docker-compose down -v --remove-orphans
elif [ "${args[0]}" = "build" ]; then
    docker build ./tools/dashboard -t ai-workspace-dashboard;
    docker build ./tools/jupyter -t ai-workspace-jupyterlab;
    docker build ./tools/mlflow -t ai-workspace-mlflow;
elif [ "${args[0]}" = "kube" ]; then
    if [ "${args[1]}" = "ns" ]; then
        if [ "${args[2]}" = "ingress" ]; then
            ns=`kubectl get namespace nginx-ingress --no-headers --output=go-template={{.metadata.name}} 2>/dev/null`
            if [ -z "${ns}" ]; then
                kubectl create namespace nginx-ingress;
                helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx;
                helm install ingress-nginx ingress-nginx/ingress-nginx -n nginx-ingress;
            else
                echo "Namespace 'nginx-ingress' already exists"
            fi
        elif [ "${#args[@]}" = 3 ]; then
            kubectl create namespace ${args[2]};
            kubectl config set-context --current --namespace=${args[2]};
        else
            echo " Provide a namespace"
            echo " "
            echo "      aiw kube ns ingress       - Creates nginx ingress controller in separate namespace" 
            echo "      aiw kube ns ai-workspace  - Creates or initializes an AI Workspace 'ai-workspace'"
        fi;
    elif [ "${args[1]}" = "install" ]; then
        helm repo add stable https://kubernetes-charts.storage.googleapis.com;
        helm repo add bitnami https://charts.bitnami.com/bitnami;
        helm dependency build kubernetes/;
        helm install ai-workspace kubernetes/;
    elif [ "${args[1]}" = "uninstall" ]; then
        helm uninstall ai-workspace;
    else
        echo " "
        echo "AI Workspace on Kubernetes"
        echo " "
        echo " Options:"
        echo "      ns          -- Creates and sets namespace" 
        echo "      install     -- Helm install" 
        echo "      uninstall   -- Helm uninstall" 
    fi;
else
    echo " "
    echo "AI Workspace"
    echo " "
    echo " Options:"
    echo "      build   -- Builds the images"
    echo "      up      -- Starts all containers"
    echo "      restart -- Restarts all containers"
    echo "      stop    -- Stops all containers"
    echo "      down    -- Stops and removes all containers"
    echo "      purge   -- Removes everything from the AI Workspace"
    echo " "
    echo "      kube ingress    -- Creates ingress controller"
    echo "      kube namespace  -- Creates namespace"
    echo "      kube install    -- Installs all components via Helm"
    echo "      kube uninstall  -- Uninstalls everything"
    echo " "
fi;
