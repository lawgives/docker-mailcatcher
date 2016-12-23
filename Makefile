# Makefile for creating container file
# Override these with environmental variables
VERSION?=0.1.0

### Do not override below

user=legalio-eng
app=mailcatcher
version=$(VERSION)
registry=gcr.io
image=$(registry)/$(user)/$(app)

all: container

container:
	gcloud docker build --tag=$(image):$(version) --tag=$(image):latest .

push:
	gcloud docker -- push $(image):$(version)

push-latest:
	docker push -- $(image):latest

push-all: push push-latest

.PHONY: all container push push-latest push-all
