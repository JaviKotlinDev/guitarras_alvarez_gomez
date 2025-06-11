FROM node:18-alpine as dev-deps
WORKDIR /app
COPY package.json package.json
RUN npm install

FROM node:18-alpine as builder
WORKDIR /app
COPY --from=dev-deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM nginx:1.123.3 as prod
EXPOSE 80
COPY --from=builder /app/dist/guitarras_alvarez_gomez /usr/share/nginx/html
CMD ["nginx", '-g', 'daemon off;']