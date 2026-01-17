YQ_CMD ?= docker run --rm -v "${PWD}":/workdir mikefarah/yq

components.yaml: schemas/*.yaml
	$(YQ_CMD) ea '. as $$item ireduce ({}; . * $$item )' $^ | \
	sed s/''[a-zA-Z/]*\.yaml#/''\#/g > $@

%-openapi.yaml: %-oai.yaml components.yaml
	$(YQ_CMD) ea 'select(fileIndex==0).components |= select(fileIndex==1).components' $^ > $@
