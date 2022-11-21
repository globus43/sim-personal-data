FROM node:current-alpine AS tailwind-css
WORKDIR /usr/src/app
COPY package.json *.js *.css *.html .
RUN npm install
RUN npx tailwindcss -o style.css -m

FROM nginx:alpine
COPY --from=tailwind-css /usr/src/app/style.css /usr/share/nginx/html/
COPY *.html favicon.png /usr/share/nginx/html/
COPY img/ /usr/share/nginx/html/img/
RUN rm -Rf /usr/share/nginx/html/_conf /etc/nginx/conf.d/default.conf
COPY _conf /etc/nginx/

WORKDIR /usr/share/nginx/html
EXPOSE 80
