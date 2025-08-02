# Dockerfile
FROM nginx:alpine

# Install curl untuk health check
RUN apk add --no-cache curl

# Copy HTML files to nginx html directory
COPY *.html /usr/share/nginx/html/

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create custom index page with app selection
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 (akan di-map ke 8888 dari luar)
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]