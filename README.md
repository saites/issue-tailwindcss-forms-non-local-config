# issue-tailwindcss-forms-non-local-config
Minimal example repo demonstrating issue with @tailwindcss/forms.
Created as required to open [this issue](https://github.com/tailwindlabs/tailwindcss-forms/issues/124).

The only difference between the working and failing example is that
the failing example uses a non-local config file,
whereas the working on uses a config file in the same directory:

```commandline
[19:42]> diff works.sh fails.sh 
8c8
<        --config /app/tailwind.config.js \
---
>        --config /code/tailwind.config.js \
```

The actual config files are identical (see the `Dockerfile`).

Running `./works.sh` works:

```commandline
[19:43]> ./works.sh 
Sending build context to Docker daemon  49.66kB
Step 1/6 : FROM node:18
 ---> 7e9550136fca
Step 2/6 : RUN mkdir /app /code
 ---> Using cache
 ---> f1794cde37ab
Step 3/6 : COPY tailwind.config.js main.css index.html /code/
 ---> Using cache
 ---> 1684c2b33b98
Step 4/6 : RUN cp /code/tailwind.config.js /app/tailwind.config.js
 ---> Using cache
 ---> d160a106acaa
Step 5/6 : WORKDIR /app
 ---> Using cache
 ---> d8443c56b8bf
Step 6/6 : RUN npm install -D tailwindcss @tailwindcss/forms
 ---> Using cache
 ---> 5f7f417804ca
Successfully built 5f7f417804ca
Successfully tagged local/tailwindcss:latest

Done in 110ms.
```

but `./fails.sh` fails with `Error: Cannot find module '@tailwindcss/forms'`:

```commandline
[19:46]> ./fails.sh 
Sending build context to Docker daemon  73.73kB
Step 1/6 : FROM node:18
 ---> 7e9550136fca
Step 2/6 : RUN mkdir /app /code
 ---> Using cache
 ---> f1794cde37ab
Step 3/6 : COPY tailwind.config.js main.css index.html /code/
 ---> Using cache
 ---> 1684c2b33b98
Step 4/6 : RUN cp /code/tailwind.config.js /app/tailwind.config.js
 ---> Using cache
 ---> d160a106acaa
Step 5/6 : WORKDIR /app
 ---> Using cache
 ---> d8443c56b8bf
Step 6/6 : RUN npm install -D tailwindcss @tailwindcss/forms
 ---> Using cache
 ---> 5f7f417804ca
Successfully built 5f7f417804ca
Successfully tagged local/tailwindcss:latest
node:internal/modules/cjs/loader:956
  const err = new Error(message);
              ^

Error: Cannot find module '@tailwindcss/forms'
Require stack:
- /code/tailwind.config.js
- /app/node_modules/tailwindcss/lib/cli.js
    at Module._resolveFilename (node:internal/modules/cjs/loader:956:15)
    at Module._load (node:internal/modules/cjs/loader:804:27)
    at Module.require (node:internal/modules/cjs/loader:1022:19)
    at require (node:internal/modules/cjs/helpers:102:18)
    at Object.<anonymous> (/code/tailwind.config.js:8:5)
    at Module._compile (node:internal/modules/cjs/loader:1120:14)
    at Module._extensions..js (node:internal/modules/cjs/loader:1174:10)
    at Module.load (node:internal/modules/cjs/loader:998:32)
    at Module._load (node:internal/modules/cjs/loader:839:12)
    at Module.require (node:internal/modules/cjs/loader:1022:19) {
  code: 'MODULE_NOT_FOUND',
  requireStack: [
    '/code/tailwind.config.js',
    '/app/node_modules/tailwindcss/lib/cli.js'
  ]
}

Node.js v18.6.0
```

