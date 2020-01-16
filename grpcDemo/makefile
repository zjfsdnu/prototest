PHONY: proto
proto:
	protoc -I ./ ./grpchello.proto --go_out=plugins=grpc:.

run:
	go run server/main.go
	go run client/main.go