# DTS OpenAPI Specs

This project provides an OpenAPI specification for [Distributed Text
Services
(DTS)](https://distributed-text-services.github.io/specifications/).

There DTS make use of some very powerful techniques that hardly can be specified with OpenAPI:

- the superb entry endpoint allows API endpoints to be spread over
  multiple base URLs or add other custom endpoints
- the use of URI templates is only [partly
supported](https://stackoverflow.com/questions/74577285/does-openapi-allow-using-rfc-6570-template-syntax-in-path-templates)
by OpenAPI

Nonetheless, OpenAPI specs for DTS are valuable because it enables
developers to generate client code or server stubs. In order to cope
with DTS's flexibility, the project splits the specs into several
files for re-use and re-combination.

## Getting Started

The most straight forward way to run the [**OpenAPI Generator
CLI**](https://openapi-generator.tech) is using the [Docker
image](https://openapi-generator.tech/docs/installation#docker):


```shell
docker run openapitools/openapi-generator-cli help
```

```shell
docker run openapitools/openapi-generator-cli help generate
```

Generating a typescript client based on Axios:

```shell
docker run -v ${PWD}:/local openapitools/openapi-generator-cli batch /local/config-ts-axios.yaml --root-dir /local
```

Types (interfaces) are in `out/typescript-axios/dts-types/*.ts`:

```shell
$ tree out/
out
└── typescript-axios
    ├── api.ts
    ├── base.ts
    ├── common.ts
    ├── configuration.ts
    ├── docs
    │   ├── Collection.md
    │   ├── CollectionMemberInner.md
    │   ├── DefaultApi.md
    │   └── Entry.md
    ├── dts-api
    │   └── default-api.ts
    ├── dts-types
    │   ├── collection-member-inner.ts
    │   ├── collection.ts
    │   ├── entry.ts
    │   └── index.ts
    ├── git_push.sh
    ├── index.ts
    ├── package.json
    ├── README.md
    └── tsconfig.json

5 directories, 18 files
```

# Contributing

See [contributing](CONTRIBUTING.md) guide.


# Further Reading

- OpenAPI Getting Started https://learn.openapis.org/
- OpenAPI Specs https://spec.openapis.org/oas/latest.html#schema-object
- Swagger Data Types https://swagger.io/docs/specification/v3_0/data-models/data-types/
- Using OpenAPI Generator CLI: https://openapi-generator.tech/docs/usage
- schema for inhomogeneous lists: https://stackoverflow.com/questions/47656791/openapi-multiple-types-inside-an-array
- splitting OpenAPI into several files: https://blog.pchudzik.com/202004/open-api-and-external-ref/
