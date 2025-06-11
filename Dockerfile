# Etapa 1: Build de Angular
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Etapa 2: Nginx para servir la app
FROM nginx:alpine

# Elimina el HTML por defecto
RUN rm -rf /usr/share/nginx/html/*

# Copia la build desde la etapa builder
COPY --from=builder /app/dist/guitarras_alvarez_gomez/browser/ /usr/share/nginx/html/

# Configuración custom de Nginx (si tienes una)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponemos el puerto
EXPOSE 80

# Healthcheck (opcional)
HEALTHCHECK --interval=30s --timeout=3s CMD wget --spider -q http://localhost || exit 1

# Arrancamos nginx
CMD ["nginx", "-g", "daemon off;"]
