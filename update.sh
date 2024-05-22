#!/bin/bash

cd /app

git pull origin main

cp index.html /usr/share/nginx/html/
