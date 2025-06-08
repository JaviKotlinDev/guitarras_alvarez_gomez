# Etapa 1: Build de Angular
FROM node:18-alpine AS builder

WORKDIR /app

# Copiamos package.json e instalamos dependencias
COPY package.json package-lock.json ./
RUN npm install

# Copiamos todo el proyecto y construimos
COPY . .
RUN npm run build

# Etapa 2: Servir con Nginx
FROM nginx:alpine

# Copiamos la build a nginx
COPY ./dist/guitarras_alvarez_gomez/browser/ /usr/share/nginx/html/

# Verificamos contenido en nginx (opcional, podés comentarlo si querés dejarlo limpio)
RUN echo "Contenido de /usr/share/nginx/html:" && ls -la /usr/share/nginx/html

# Exponemos el puerto
EXPOSE 80

# Healthcheck para validar que esté sirviendo correctamente
HEALTHCHECK --interval=30s --timeout=3s CMD wget --spider -q http://localhost || exit 1

# Arrancamos nginx
CMD ["nginx", "-g", "daemon off;"]