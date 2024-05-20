#!/bin/bash

# Start Minikube with Docker driver
minikube start --nodes=3 --driver=docker

# Set kubectl context
kubectl config use-context minikube
