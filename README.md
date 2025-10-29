# DTS OpenAPI Specs


## OpenAPI Generator CLI with Docker



```shell
docker run openapitools/openapi-generator-cli help
```

```shell
docker run openapitools/openapi-generator-cli help generate
```

```shell
docker run \
	   -v ${PWD}:/local \
	   openapitools/openapi-generator-cli generate \
	   -i /local/static-collection-openapi.yaml \
	   -g typescript-axios \
	   -o /local/out/typescript-axios \
	   -c /local/config/typescript-axios.yaml
```
