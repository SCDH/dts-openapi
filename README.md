# DTS OpenAPI Specs

This project provides an OpenAPI specification for [Distributed Text
Services
(DTS)](https://distributed-text-services.github.io/specifications/). RESTful
DTS make use of some very powerful techniques that can hardly be
mastered with OpenAPI:

- the superb entry endpoint allows API endpoints to be spread over
  multiple base URLs or to add other custom endpoints
- the use of URI templates is only [partly
supported](https://stackoverflow.com/questions/74577285/does-openapi-allow-using-rfc-6570-template-syntax-in-path-templates)
by OpenAPI
- DTS is designed upon the
  [HATEOAS](https://en.wikipedia.org/wiki/HATEOAS), while
  OpenAPI/SwaggerUI knows all URLs in advance

Nonetheless, OpenAPI specs for DTS are valuable because they enable
developers to generate boilerplate client code or server stubs. The
very fact of having data types generated for client or server is a
clear profit. In order to cope with DTS's flexibility, the project
splits the specs into several files for re-use and re-combination.

- DTS Servers can fully use OpenAPI specs to describe their endpoints.
- DTS Clients
  1. have to implement URI templates for **getting** data from a DTS
	 service. Currently, this aspect cannot be expressed (AFAIK) by
	 OpenAPI.
  1. can use the types generated from the OpenAPI specs for the
     **response body**.


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
docker run \
	   -v ${PWD}:/local \
	   openapitools/openapi-generator-cli generate \
	   -i /local/static-collection-openapi.yaml \
	   -g typescript-axios \
	   -o /local/out/typescript-axios \
	   --additional-properties=withSeparateModelsAndApi=true,apiPackage=dts-api,modelPackage=dts-types,withInterfaces=true,npmName="@scdhapis/dts-api"
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

## Files and Directories

- `*-openapi.yaml`: OpenAPI specs
- `schemas/*.yaml`: OpenAPI schema specifications for re-use
- `params/*.yaml`: OpenAPI parameter specifications for re-use
- `pom.xml`: Maven project with config for homogenously generating all artifacts

## Maven builds

This project uses
[Maven](https://github.com/OpenAPITools/openapi-generator/tree/master?tab=readme-ov-file#32---workflow-integration-maven-gradle-github-cicd),
because it enables us to keep all the configurations for the generated
packages in one place. That's important for propagating the same
release numbers to all artifacts. Single source of truth for release
numbers are git commit tags.


## Contributing

See [contributing](CONTRIBUTING.md) guide.


## Further Reading

- OpenAPI Getting Started https://learn.openapis.org/
- OpenAPI Specs https://spec.openapis.org/oas/latest.html#schema-object
- Swagger Data Types https://swagger.io/docs/specification/v3_0/data-models/data-types/
- Using OpenAPI Generator CLI: https://openapi-generator.tech/docs/usage
- schema for inhomogeneous lists: https://stackoverflow.com/questions/47656791/openapi-multiple-types-inside-an-array
- splitting OpenAPI into several files: https://blog.pchudzik.com/202004/open-api-and-external-ref/
