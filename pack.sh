#!/bin/bash

version_name=`date +"%Y%m%d%H%M%S".zip`
mv ./lambda_function.zip "./versions/${version_name}"
zip -rq lambda_function.zip lambda_function.rb vendor/ .env lib/ config/