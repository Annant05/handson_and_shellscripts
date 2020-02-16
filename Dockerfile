# you can create a specific stage in dockerfile
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# then use the above output to be copied to another container
FROM nginx
# the below line copies the files generated in 
# /app/build of the above container to the nginx html directory
COPY --from=builder /app/build /usr/share/nginx/html
