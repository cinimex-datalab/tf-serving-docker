#############
# Variables #
#############
TFSERVE_DOCKERFILE_PATH=./Dockerfile
TFSERVE_IMAGE_NAME=cmxdatalab/tf-serving:latest

# servables will be exported to this directory after model traning completes
SERVABLES_PATH=$(CURDIR)/serving

#############
# Tasks     #
#############
clean:
	rm -rf ./serving	

tfserve_image: $(TFSERVE_DOCKERFILE_PATH)
	docker build -f $(TFSERVE_DOCKERFILE_PATH) -t $(TFSERVE_IMAGE_NAME) .

run_server: $(SERVABLES_PATH) 
	docker run -p8500:8500 -d --rm -v $(SERVABLES_PATH):/models $(TFSERVE_IMAGE_NAME)

push_image:
	docker push $(TFSERVE_IMAGE_NAME)

