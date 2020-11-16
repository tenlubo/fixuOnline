FROM nginx:stable-alpine
LABEL version="0.2.0"
LABEL maintainer="Lubo Sladok <ten.lubo@hotmail.com>"

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /usr/share/nginx/html
COPY dist/ .

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
