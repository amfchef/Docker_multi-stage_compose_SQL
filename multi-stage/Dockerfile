FROM ubuntu as builder

COPY . .

FROM nginx

COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf

COPY --from=builder . /usr/share/nginx/html