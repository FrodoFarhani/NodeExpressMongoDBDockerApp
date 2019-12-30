# Build: docker build -f node.dockerfile -t so0oshiance/node .

# Option 1
# Start MongoDB and Node (link Node to MongoDB container with legacy linking)
 
# docker run -d --name my-mongodb mongo
# docker run -d -p 3000:3000 --link my-mongodb:mongodb --name nodeapp so0oshiance/node
# my-mongodb:mongodb => mongodb is an alias in the node container we choose. You can see it in config>config.development.js file

# Option 2: Create a custom bridge network and add containers into it

# docker network create --driver bridge isolated_network
# docker run -d --net=isolated_network --name mongodb mongo
# --name mongodb : Means link to this container with nogodb
# docker run -d --net=isolated_network --name nodeapp -p 3000:3000 so0oshiance/node

# Seed the database with sample database
# Run: docker exec nodeapp node dbSeeder.js
# With exec you can run command in specific container with its name or id [nodeapp or 71]

FROM node:latest

MAINTAINER Dan Wahlin

ENV NODE_ENV=development 
ENV PORT=3000

COPY      . /var/www
WORKDIR   /var/www

RUN       npm install

EXPOSE $PORT

ENTRYPOINT ["npm", "start"]