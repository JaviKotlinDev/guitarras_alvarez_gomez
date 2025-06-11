# Etapa 1: Build de Angular
FROM node:18-alpine AS builder

WORKDIR /app

# Copiamos package.json e instalamos dependencias
COPY package.json package-lock.json ./
RUN npm install

# Copiamos todo el proyecto y construimos con base-href
COPY . .
RUN npm run build -- --base-href=/

# Etapa 2: Servir con Nginx
FROM nginx:alpine

# Copiamos la build a nginx
COPY ./dist/guitarras_alvarez_gomez/browser /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN ls -la /usr/share/nginx/html

# (Opcional) Verificamos contenido en nginx
RUN echo "Contenido de /usr/share/nginx/html:" && ls -la /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s CMD wget --spider -q http://localhost || exit 1

CMD ["nginx", "-g", "daemon off;"]