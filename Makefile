YQ_CMD ?= docker run --rm -v "${PWD}":/workdir mikefarah/yq

SPECS := $(wildcard *-openapi.yaml)
SPECS_INTERNAL := $(patsubst %,internal/%,$(SPECS))

echo:
	echo "found specs: $(SPECS)"

all: internal internal/components.yaml $(SPECS_INTERNAL)

internal/components.yaml: components/*.yaml
	$(YQ_CMD) ea '. as $$item ireduce ({}; . * $$item )' $^ | \
	sed s/''[a-zA-Z/]*\.yaml#/''\#/g > $@

internal/%-openapi.yaml: %-openapi.yaml internal/components.yaml
	$(YQ_CMD) ea 'select(fileIndex==0).components = select(fileIndex==1).components | select(fileIndex==0)' $^  | \
	sed s/''[a-zA-Z/-]*\.yaml#/''\#/g > $@

.PHONY:
internal:
	mkdir -p $@
