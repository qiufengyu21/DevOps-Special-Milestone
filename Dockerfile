FROM ubuntu:16.04

RUN apt-get update

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs

#mongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
RUN apt-get update
RUN apt-get install -y mongodb

#nginx
RUN apt-get install -y nginx
CMD service nginx restart
COPY ./checkbox.io /checkbox.io
COPY /checkbox.io/local-conf/nginx.conf /etc/nginx/nginx.conf
COPY /checkbox.io/local-conf/default /etc/nginx/sites-available/default
RUN cd /checkbox.io/server-side/site && npm install
