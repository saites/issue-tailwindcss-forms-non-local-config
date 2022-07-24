#!/usr/bin/env bash

docker build -t local/tailwindcss .

docker run --rm -it \
  local/tailwindcss \
    npx tailwindcss \
       --config /app/tailwind.config.js \
       --input /code/main.css \
       --output /code/dist/css/main.css

