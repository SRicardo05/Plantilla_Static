# Usar versión específica para reproducibilidad

FROM nginx:1.25-alpine

# Metadata del contenedor
LABEL maintainer="hosting-platform"
LABEL project.type="static"
LABEL platform="hosting-platform"

# Copiar todo el contenido público de una vez
# nginx:alpine ya incluye usuario 'nginx' (uid=101, gid=101)
COPY --chown=nginx:nginx ./public /usr/share/nginx/html

# Healthcheck para verificar que nginx responde
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

USER viewer

EXPOSE 80

# Nginx corre como root pero los workers como nginx
CMD ["nginx", "-g", "daemon off;"]
