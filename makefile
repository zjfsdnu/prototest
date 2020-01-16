
.PHONY: proto clean go gotest p2

proto:
	protoc --go_out=simple simple.proto
	protoc --go_out=tutorial addressbook.proto

p2:
	protoc -I grpcDemo/ grpcDemo/grpchello.proto --go_out=plugins=grpc:grpcDemo


go:     add_person_go     list_people_go
gotest: add_person_gotest list_people_gotest

protoc_middleman_go: addressbook.proto
	mkdir -p tutorial # make directory for go package
	protoc --go_out=tutorial addressbook.proto
	@touch protoc_middleman_go

add_person_go: add_person.go protoc_middleman_go
	go build -o add_person_go add_person.go

add_person_gotest: add_person_test.go add_person_go
	go test add_person.go add_person_test.go

list_people_go: list_people.go protoc_middleman_go
	go build -o list_people_go list_people.go

list_people_gotest: list_people.go list_people_go
	go test list_people.go list_people_test.go

clean:
	rm -f protoc_middleman_go tutorial/*.pb.go add_person_go list_people_go
	find . -regex '.*\.out\|.*\.exe\|.*\.i\|.*\.s\|.*\.o' | xargs rm -f
