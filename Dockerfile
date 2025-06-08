FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json /app
RUN npm install

COPY . .

RUN npm run build

RUN ls -la /app/dist
RUN ls -la /app/dist/guitarras_alvarez_gomez

# Etapa 2: Servir con NGINX (funciona en ARM)
FROM nginx:alpine

COPY --from=builder /app/dist/guitarras_alvarez_gomez /usr/share/nginx/html

RUN ls -la /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]