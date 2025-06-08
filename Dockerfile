# Etapa 1: Build de Angular
FROM node:18-alpine AS builder

WORKDIR /app

# Copiamos package.json e instalamos dependencias
COPY package.json package-lock.json ./
RUN npm install

# Copiamos todo y construimos
COPY . .
RUN npm run build

# Verificamos que el build se haya generado correctamente
RUN echo "Contenido de /app/dist:" && ls -la /app/dist
RUN echo "Contenido de /app/dist/guitarras_alvarez_gomez:" && ls -la /app/dist/guitarras_alvarez_gomez

# Etapa 2: Servir con Nginx
FROM nginx:alpine

# Copiamos la build a nginx
COPY --from=builder /app/dist/guitarras_alvarez_gomez /usr/share/nginx/html

# Verificamos contenido en nginx
RUN echo "Contenido de /usr/share/nginx/html:" && ls -la /usr/share/nginx/html

# Exponemos el puerto
EXPOSE 80

# Healthcheck para validar que esté sirviendo correctamente
HEALTHCHECK --interval=30s --timeout=3s CMD wget --spider -q http://localhost || exit 1

# Arrancamos nginx
CMD ["nginx", "-g", "daemon off;"]