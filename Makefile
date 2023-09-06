SHELL:=/usr/bin/env bash

default: help
# via https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Run docker build to build the ssh:latest image.
	docker build -t ssh:latest .

.PHONY: clean
clean: ## Remove build products.
	docker image rm ssh
	rm -rf ./out

.PHONY: image-tar
image-tar: clean build ## Build ssh:latest and save the image to ./out.
	docker save -o ./out/ssh-latest.tar ssh:latest
