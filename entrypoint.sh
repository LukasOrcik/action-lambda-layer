#!/bin/bash
set -euo pipefail

install_zip_dependencies(){
	echo "Installing and zipping dependencies..."
	mkdir python
	pip install --target=python -r "${INPUT_REQUIREMENTS_TXT}" --no-cache-dir
	cp -r * python/
	echo $(INPUT_PACKAGE_PATH)
	zip -r dependencies.zip ./python
}

publish_dependencies_as_layer(){
	echo "Publishing dependencies as a layer..."
	local result=$(aws lambda publish-layer-version --layer-name ${INPUT_LAMBDA_LAYER_ARN} --compatible-architectures ${INPUT_ARCHITECTURES} --compatible-runtimes ${INPUT_RUNTIMES} --zip-file fileb://dependencies.zip)
	LAYER_VERSION=$(jq '.Version' <<< "$result")
	rm -rf python
	rm dependencies.zip
	echo -n $LAYER_VERSION
}


deploy_lambda_layer(){
	install_zip_dependencies
	publish_dependencies_as_layer
}

deploy_lambda_layer
echo "Done."