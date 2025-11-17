# ----- Etapa 1: Construcción (Build Stage) -----
# Usamos una imagen de Node 18 (Alpine es más ligera)
FROM node:18-alpine AS build
WORKDIR /app
# Copiamos los package.json e instalamos dependencias
COPY package*.json ./
RUN npm install
# Copiamos el resto del código fuente
COPY . .
# Construimos la app para producción
RUN npm run build

# ----- Etapa 2: Producción (Production Stage) -----
# Usamos una imagen de Nginx para servir el contenido estático
FROM nginx:stable-alpine AS production
# Copiamos los archivos estáticos construidos (de la carpeta 'dist')
COPY --from=build /app/dist /usr/share/nginx/html
# (Opcional) Si necesitas una config de Nginx personalizada, la copias aquí
# COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
# El comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]