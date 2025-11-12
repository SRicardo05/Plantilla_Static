
# Imagen base de Node.js
FROM node:18-alpine

# Instalamos http-server para servir contenido estático
RUN npm install -g http-server

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos del sitio estático
COPY public/ /app/public/

# Exponemos el puerto 8080 para probar la plantilla
EXPOSE 80

# Usuario no root
RUN addgroup -S app && adduser -S app -G app
USER app

# Comando para lanzar el servidor HTTP
CMD ["http-server", "public", "-p", "8080", "--cors"]

