FROM node:4.4.5

RUN mkdir -p /opt/dummy
ADD . /opt/dummy

WORKDIR /opt/dummy
RUN npm install --production

EXPOSE 3000

CMD ["npm", "start"]
