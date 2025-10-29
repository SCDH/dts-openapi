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

Types (interfaces) are in `out/typescript-axios/dts-types/*.ts`:

```shell
$ tree out/
out/
└── typescript-axios
    ├── api.ts
    ├── base.ts
    ├── common.ts
    ├── configuration.ts
    ├── docs
    │   ├── Collection200Response.md
    │   ├── DefaultApi.md
    │   └── Entry200Response.md
    ├── dts-api
    │   └── default-api.ts
    ├── dts-types
    │   ├── collection200-response.ts
    │   ├── entry200-response.ts
    │   └── index.ts
    ├── git_push.sh
    ├── index.ts
    ├── package.json
    ├── README.md
    └── tsconfig.json
 
5 directories, 16 files
```


# Further Reading

- OpenAPI Getting Started https://learn.openapis.org/
- OpenAPI Specs https://spec.openapis.org/oas/latest.html#schema-object
- Swagger Data Types https://swagger.io/docs/specification/v3_0/data-models/data-types/
- Using OpenAPI Generator CLI: https://openapi-generator.tech/docs/usage

