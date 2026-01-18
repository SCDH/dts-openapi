YQ_CMD ?= docker run --rm -v "${PWD}":/workdir mikefarah/yq

OAG_MNT ?= /local
OAG_CMD ?= docker run -v ${PWD}:$(OAG_MNT) openapitools/openapi-generator-cli


SPECS := $(wildcard *-openapi.yaml)
SPECS_INTERNAL := $(patsubst %,internal/%,$(SPECS))

OAG_CONFIGS := $(wildcard oagen/*.yaml)
OAG_TARGETS := $(patsubst oagen/%.yaml,out/%,$(OAG_CONFIGS))

echo:
	echo "found specs: $(SPECS)"

all: internal internal/components.yaml $(SPECS_INTERNAL) $(OAG_TARGETS)

internal/components.yaml: components/*.yaml
	$(YQ_CMD) ea '. as $$item ireduce ({}; . * $$item )' $^ | \
	sed s/''[a-zA-Z/]*\.yaml#/''\#/g > $@

internal/%-openapi.yaml: %-openapi.yaml internal/components.yaml
	$(YQ_CMD) ea 'select(fileIndex==0).components = select(fileIndex==1).components | select(fileIndex==0)' $^  | \
	sed s/''[a-zA-Z/-]*\.yaml#/''\#/g > $@

.PHONY:
internal:
	mkdir -p $@

# generates code for every config file in oagen to out
out/%: oagen/%.yaml
	$(OAG_CMD) batch $(OAG_MNT)/$< --root-dir /local --verbose --clean

# legacy, but may be useful for diagnostics
out/typescript-axios/package.json: internal/dts-openapi.yaml
	$(OAG_CMD) generate \
	-i $(OAG_MNT)/internal/dts-openapi.yaml \
	-g typescript-axios \
	-o $(OAG_MNT)/out/typescript-axios \
	--additional-properties=withSeparateModelsAndApi=true,apiPackage=dts-api,modelPackage=dts-types,withInterfaces=true,npmName="@scdhapis/dts-api-axios",useSingleRequestParameter=true

out/typescript-fetch/package.json: internal/dts-openapi.yaml
	$(OAG_CMD) generate \
	-i $(OAG_MNT)/internal/dts-openapi.yaml \
	-g typescript-fetch \
	-o $(OAG_MNT)/out/typescript-fetch \
	--additional-properties=withSeparateModelsAndApi=true,apiPackage=dts-api,modelPackage=dts-types,withInterfaces=true,npmName="@scdhapis/dts-api",useSingleRequestParameter=true



clean:
	sudo rm -Rf out
