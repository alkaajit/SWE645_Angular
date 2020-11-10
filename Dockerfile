### STAGE 1: Build ###
FROM node:12.7-alpine AS build
WORKDIR /usr/src/app
COPY . ./
RUN npm install
RUN npm run build

### STAGE 2: Run ###

COPY . /usr/src/app
COPY  npm start --host 0.0.0.0 --disableHostCheck true

EXPOSE 8080
EXPOSE 4200
