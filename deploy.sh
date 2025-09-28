#!/bin/bash

# === Variables ===
DOCKER_USER="<dockerhub-username>"
APP_NAME="datetime-webapp"
IMAGE_TAG="latest"
IMAGE="$DOCKER_USER/$APP_NAME:$IMAGE_TAG"

echo "[1/6] Building Go binary..."
go mod tidy
go build -o server main.go

echo "[2/6] Building Docker image..."
docker build -t $IMAGE .

echo "[3/6] Pushing Docker image..."
docker push $IMAGE

echo "[4/6] Deploying Deployment..."
kubectl apply -f deployment.yaml

echo "[5/6] Deploying Service..."
kubectl apply -f service.yaml

echo "[6/6] Checking status..."
kubectl get pods -l app=datetime
kubectl get svc datetime-service
