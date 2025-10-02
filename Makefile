.PHONY: help 

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth: ## auth with aws
	aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 826895066148.dkr.ecr.ap-southeast-1.amazonaws.com
build-push:
	make build
	make push
build: ## build image
	docker build -t laravel-api-v3-base-image .
push: ## push image to ECR
	docker tag laravel-api-v3-base-image:latest 826895066148.dkr.ecr.ap-southeast-1.amazonaws.com/laravel-api-v3-base-image:latest
	docker push 826895066148.dkr.ecr.ap-southeast-1.amazonaws.com/laravel-api-v3-base-image:latest