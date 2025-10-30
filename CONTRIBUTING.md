# Contributing


## Adding Schemas

OpenAPI schemas go into the `schemas` folder. One type per file. Each
file MUST have the structure, which is essential for the generated
types:

```yaml
components:
  schemas:
    MyType:
      ...
```

Without `/components/schemas` type references will fail and recursive
types will be unusable.
