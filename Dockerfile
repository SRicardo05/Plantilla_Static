# Base original
FROM nginx:1.25-alpine

# Metadata
LABEL maintainer="hosting-platform"
LABEL project.type="static"
LABEL platform="hosting-platform"

# Copiar contenido público
COPY --chown=nginx:nginx ./public /usr/share/nginx/html

# Instalar herramientas de stress
# Alpine usa apk como gestor de paquetes
RUN apk add --no-cache bash coreutils stress curl

# Healthcheck para nginx
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -sSf http://localhost/ || exit 1

EXPOSE 80

# Script de stress opcional
# Puedes ejecutar stress directamente con docker exec
# CMD por defecto deja nginx corriendo
CMD ["nginx", "-g", "daemon off;"]
