# Base original
FROM nginx:1.25-alpine

# Copiar contenido público
COPY ./public /usr/share/nginx/html

# Instalar herramientas (stress-ng para pruebas)
RUN apk add --no-cache bash coreutils curl stress-ng \
    && rm -rf /var/cache/apk/*

CMD ["nginx", "-g", "daemon off;"]
