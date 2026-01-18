# DTS OpenAPI Specs

This project provides building blocks for OpenAPI specifications for
[Distributed Text Services
DTS](https://distributed-text-services.github.io/specifications/).
Yes, we concede: There's friction between OpenAPI and REST APIs. While
OpenAPI specifications describes a priori, which endpoints are there,
REST APIs allow much more adaptive interactions by using hypermedia
controls. DTS is a RESTful API and thus makes use of some very
powerful techniques that can hardly be mastered with OpenAPI:

- the superb entry endpoint introduces discoverability: API endpoints
  can be spread over multiple base URLs, even custom endpoints may be
  added
- the use of URI templates is only [partly
supported](https://stackoverflow.com/questions/74577285/does-openapi-allow-using-rfc-6570-template-syntax-in-path-templates)
by OpenAPI
- DTS is designed upon the
  [HATEOAS](https://en.wikipedia.org/wiki/HATEOAS), while
  OpenAPI/SwaggerUI knows all endpoints in advance

Nonetheless, OpenAPI specs for DTS are valuable because they enable
software developers to generate server stubs and even parts of
boilerplate client code. The very fact of having data types generated
for client or server is a clear profit. In order to cope with DTS's
flexibility, the project splits the specs into several files for
re-use and re-combination. It offers bricks.

- DTS Servers can fully use OpenAPI specs to describe their endpoints.
- DTS Clients
  1. have to implement URI templates for **getting** data from a DTS
	 service. Currently, this aspect cannot be expressed (AFAIK) by
	 OpenAPI.
  1. can use the types and parsing functions generated from the
     OpenAPI specs for the **response body**.


## Getting Started

The following command generates code for all OpenAPI generator
configurations in the [`oagen`](oagen) directory. Generated code is
written to the `out` folder.

```shell
make all
```

This runs the [**OpenAPI Generator
CLI**](https://openapi-generator.tech) in the [Docker
image](https://openapi-generator.tech/docs/installation#docker). Generated
code is written to the `out` folder.

For example, interfaces (types) for a typescript client are in
`out/typescript-fetch/src/models/*.ts`:

```shell
$ tree out/typescript-fetch
out/typescript-fetch
├── docs
│   ├── CitableUnit.md

[...]

│   └── Resource.md
├── package.json
├── README.md
├── src
│   ├── apis
│   │   ├── DefaultApi.ts
│   │   └── index.ts
│   ├── index.ts
│   ├── models
│   │   ├── CitableUnit.ts
│   │   ├── CitationTree.ts
│   │   ├── CiteStructure.ts
│   │   ├── CollectionMemberInner.ts
│   │   ├── Collection.ts
│   │   ├── DublinCore.ts
│   │   ├── Entry.ts
│   │   ├── index.ts
│   │   ├── Navigation.ts
│   │   ├── Pagination.ts
│   │   └── Resource.ts
│   └── runtime.ts
└── tsconfig.json
 
5 directories, 29 files
```

## Using docker

If you want to use [**OpenAPI Generator
CLI**](https://openapi-generator.tech) directly using [Docker
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
	   -i /local/standalone/dts-openapi.yaml \
	   -g typescript-axios \
	   -o /local/out/typescript-axios \
	   --additional-properties=withSeparateModelsAndApi=true,apiPackage=dts-api,modelPackage=dts-types,withInterfaces=true,npmName="@scdhapis/dts-api",useSingleRequestParameter=true
```

## Standalone Specs

The OpenAPI specs in the root directory of this repository include
re-usable components in the [`components`](components) folder. Because
including components is error-prone, we also provide generated
standalone counterparts with components interned into to [`components`
section](https://spec.openapis.org/oas/latest.html#components-object). These
standalone counterparts live in the [`standalone`](standalone) folder. For
generating code it's **recommended to use these standalone specs**.

You should never edit the standalone specs directly. They are
generated from the components and the specs in the base folder.

The following command updates all standalone specs: 

```shell
make intern
```

## Files and Directories

- `*-openapi.yaml`: OpenAPI specs
- `components/*.yaml`: OpenAPI components: re-usable specifications for schema, parameters, etc.
- `oagen/*.yaml`: config files for OpenAPI generator
- `standalone/*-openapi.yaml`: standalone specs derived from `*-openapi.yaml` files in the base directory



## Contributing

See [contributing](CONTRIBUTING.md) guide.

## REST

- REST APIs must be hypertext driven, by Roy Fielding,
  https://roy.gbiv.com/untangled/2008/rest-apis-must-be-hypertext-driven
- Martin Fowler about the "Richardson Maturity Model", https://martinfowler.com/articles/richardsonMaturityModel.html
- OpenAPI (Swagger) vs. HATEOAS: https://www.baeldung.com/java-rest-swagger-vs-hateoas

## Further Reading

- OpenAPI Getting Started https://learn.openapis.org/
- OpenAPI Specs https://spec.openapis.org/oas/latest.html#schema-object
- Swagger Data Types https://swagger.io/docs/specification/v3_0/data-models/data-types/
- Using OpenAPI Generator CLI: https://openapi-generator.tech/docs/usage
- schema for inhomogeneous lists: https://stackoverflow.com/questions/47656791/openapi-multiple-types-inside-an-array
- splitting OpenAPI into several files: https://blog.pchudzik.com/202004/open-api-and-external-ref/
- OpenAPI and RFC6570 URI templates:
  - https://stackoverflow.com/questions/74577285/does-openapi-allow-using-rfc-6570-template-syntax-in-path-templates
  - https://github.com/swaggerexpert/openapi-server-url-templating
