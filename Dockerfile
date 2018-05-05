FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y build-essential git vim curl

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs
# Networking tools
RUN apt-get install -y iproute2

# Cat facts server
COPY . /srv
RUN cd /srv && npm install
EXPOSE 3000

# CMD [ "npm", "start" ]

#mongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
RUN apt-get update
RUN apt-get install -y mongodb-org
RUN service mysql restart
RUN mongo admin --eval "db.createUser({user: 'admin', pwd: 'admin123', roles:[{role:'root',db:'admin'}]});"

WORKDIR /srv
