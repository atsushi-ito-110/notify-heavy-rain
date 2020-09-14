#!/bin/bash

rm ./lambda_function.zip
zip -rq lambda_function.zip lambda_function.rb vendor/ .env lib/ config/