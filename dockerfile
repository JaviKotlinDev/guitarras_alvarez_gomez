# Etapa 1: Construcción con Node (funciona en ARM)
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Etapa 2: Servir con NGINX (funciona en ARM)
FROM nginx:alpine

COPY --from=builder /app/dist/guitarras_alvarez_gomez /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]