#!/bin/bash

for app in catalog_detail product_catalog; do
    export APP_VERSION=1.0
    aws ecr describe-repositories --repository-name $PROJECT_NAME/$app >/dev/null 2>&1 || \
    aws ecr create-repository --repository-name $PROJECT_NAME/$app >/dev/null
    TARGET=$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME/$app:$APP_VERSION
    docker buildx build -t $TARGET apps/$app --platform linux/amd64
    docker push $TARGET
done


for app in frontend_node; do
    export APP_VERSION=2.0
    aws ecr describe-repositories --repository-name $PROJECT_NAME/$app >/dev/null 2>&1 || \
    aws ecr create-repository --repository-name $PROJECT_NAME/$app >/dev/null
    TARGET=$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME/$app:$APP_VERSION
    docker buildx build -t $TARGET apps/$app --platform linux/amd64
    docker push $TARGET
done


