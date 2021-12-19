FROM nginx:latest

RUN apt-get update && \
    apt-get install -y apt-utils locales && \
    sed -i -e 's/# ja_JP.UTF-8/ja_JP.UTF-8/g' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_TIME C

RUN rm -rf /etc/nginx/conf.d/*

COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/proxy.conf /etc/nginx/conf.d/proxy.conf

EXPOSE 80
