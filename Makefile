#!/usr/bin/make
# Makefile readme (ru): <http://linux.yaroslavl.ru/docs/prog/gnu_make_3-79_russian_manual.html>
# Makefile readme (en): <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

docker_bin := $(shell command -v docker 2> /dev/null)
dc_bin := $(shell command -v docker-compose 2> /dev/null)
project_id := $(shell basename $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
docker_containers_unique_label := $(project_id)-unique-label
cwd = $(shell pwd)

SHELL = /bin/bash
NODE_IMAGE = tarampampam/node:13-alpine
FRONTEND_PORT = 8080
RUN_ARGS = --label "$(docker_containers_unique_label)" --rm -v "$(shell pwd):/src:cached" \
           --workdir "/src" -u "$(shell id -u):$(shell id -g)"
RUN_INTERACTIVE ?= --tty --interactive

.PHONY : help install test fix build shell watch clean push destroy pull release
.SILENT : help install test fix build shell watch push destroy release
.DEFAULT_GOAL : help

# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help
	@printf "\033[33m%s:\033[0m\n" 'Available commands'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[32m%-18s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install all dependencies
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) "$(NODE_IMAGE)" yarn install

test: ## Execute tests and linters
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) "$(NODE_IMAGE)" bash -c "yarn run lint && yarn run test:unit"

lint: ## Execute tests and linters
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) "$(NODE_IMAGE)" bash -c "yarn run lint"

fix: ## Execute sources fixing
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) "$(NODE_IMAGE)" yarn run lint:fix

shell: ## Start shell into container with node
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) \
	  -e "PS1=\[\033[1;32m\]🐳 \[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]" \
	  "$(NODE_IMAGE)" bash

serve: ## Start watching assets for changes
	@printf "\n  \033[1;42m  %s  \033[0m\n\n" 'Navigate your browser to ⇒ http://127.0.0.1:$(FRONTEND_PORT)'
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) -p "$(FRONTEND_PORT):8080" "$(NODE_IMAGE)" yarn run serve

destroy: ## Kill all spawned (and probably disowned) docker-containers
	$(docker_bin) kill `$(docker_bin) ps --filter "label=$(docker_containers_unique_label)" --format '{{.ID}}'`

clean: ## Make some clean
	rm -Rf "$(shell pwd)/coverage"

build: clean ## Build application bundle (and docker image)
	$(docker_bin) run $(RUN_ARGS) $(RUN_INTERACTIVE) -e "NODE_ENV=production" "$(NODE_IMAGE)" yarn run build

logs: ## Show docker logs
	$(dc_bin) logs --follow

