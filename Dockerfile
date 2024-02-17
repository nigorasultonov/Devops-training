FROM httpd:latest
EXPOSE 80
docker build -t my-apache-image .
docker run -d -p 8080:80 my-apache-image
