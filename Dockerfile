# Usar versión específica para reproducibilidad
FROM nginx:1.25-alpine

# Metadata del contenedor
LABEL maintainer="hosting-platform"
LABEL project.type="static"
LABEL platform="hosting-platform"

# Crear usuario no-root para nginx
RUN addgroup -g 101 -S nginx-app && \
    adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx-app -g nginx-app nginx-app

# Copiar todo el contenido público de una vez
COPY --chown=nginx-app:nginx-app ./public /usr/share/nginx/html

# Dar permisos necesarios
RUN chown -R nginx-app:nginx-app /usr/share/nginx/html && \
    chown -R nginx-app:nginx-app /var/cache/nginx && \
    chown -R nginx-app:nginx-app /var/log/nginx && \
    chown -R nginx-app:nginx-app /etc/nginx/conf.d && \
    touch /var/run/nginx.pid && \
    chown -R nginx-app:nginx-app /var/run/nginx.pid

# Cambiar a usuario no-root
USER nginx-app

# Healthcheck para verificar que nginx responde
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

EXPOSE 80

# Comando por defecto (nginx ya lo trae, pero explícito)
CMD ["nginx", "-g", "daemon off;"]