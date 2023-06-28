#Stage 1
FROM node:16-alpine as builder
WORKDIR /capstone
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#Stage 2
FROM nginx:1.19.0-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /capstone/build .
ENTRYPOINT ["nginx","-g","daemon off;"]