IMAGE  = clinical-image-validation
CNAME  = clinical-image-validation
PORT   = 8503

.PHONY: build build-uv run stop up down logs clean

## Build image using pip (default)
build:
	docker build -t $(IMAGE) .

## Build image using uv
build-uv:
	docker build --build-arg USE_UV=1 -t $(IMAGE) .

## Run a detached container
run:
	docker run -d --name $(CNAME) -p $(PORT):$(PORT) $(IMAGE)

## Stop and remove the container
stop:
	docker stop $(CNAME) && docker rm $(CNAME)

## Build + run in one command (default entry point)
up: build run

## Alias for stop
down: stop

## Stream container logs
logs:
	docker logs -f $(CNAME)

## Stop container and remove image
clean: stop
	docker rmi $(IMAGE)
