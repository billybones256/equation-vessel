.PHONY:proto
proto:
	protoc -I. --go_out=plugins=micro:. proto/vessel/vessel.proto 

.PHONY:push
push:
	$(SUDO) docker push billybones256/equation-vessel:initial

.PHONY:build
build:
	docker build -t equation-vessel .

.PHONY:run
run:
	docker run -p 50053:50051 -e MICRO_SERVER_ADDRESS=:50051 equation-vessel

.DEFAULT_GOAL := proto