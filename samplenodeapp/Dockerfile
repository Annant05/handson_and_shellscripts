FROM node:alpine 

# use WORKDIR to create a new directory and set it as PWD
WORKDIR /usr/app

# copy the package.json in advance to optimize npm install by docker.
COPY ./package.json ./
RUN npm install


COPY ./ ./  

CMD ["npm","start"]

EXPOSE 8080