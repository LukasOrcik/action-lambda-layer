# Deploy lambda layer

A Github Action to deploy AWS Lambda functions written in Python with their dependencies in a layer.

### Pre-requisites
The Action to have access to the code, you must use the `actions/checkout@master`.

### Example workflow
```yaml
name: deploy-lambda-layer
on:
  push:
    branches:
      - master
jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@master
    - name: Lambda layer for python
      uses: LukasOrcik/action-lambda-layer@0.1.0
      with:
        lambda_layer_arn: 'arn:aws:lambda:us-east-2:123456789012:layer:my-layer'
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_DEFAULT_REGION: 'us-east-2'

```