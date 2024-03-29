FROM nginx:stable

# Add a user 'nginxuser'
RUN useradd -m nginxuser

# Set the working directory and change the ownership to the newly created user
WORKDIR /usr/share/nginx/html
RUN chown -R nginxuser:nginxuser /usr/share/nginx/html

# Copy index.html to the working directory
COPY index.html .

# Add a health check command
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD curl --fail http://localhost/ || exit 1

# Switch to the nginxuser
USER nginxuser

# CMD instruction to start the NGINX server
CMD ["nginx", "-g", "daemon off;"]

