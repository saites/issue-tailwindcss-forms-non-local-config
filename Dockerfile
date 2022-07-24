FROM node:18

RUN mkdir /app /code

COPY tailwind.config.js main.css index.html /code/
RUN cp /code/tailwind.config.js /app/tailwind.config.js

WORKDIR /app
RUN npm install -D tailwindcss @tailwindcss/forms

