# Node.js with MongoDB and Docker Demo

Application demo designed to show how Node.js and MongoDB can be run in Docker containers.
The app uses Mongoose to create a simple database that stores Docker commands and examples.

##To run the app with Docker Containers:

1. Install Docker Toolbox (http://docker.com/toolbox).

2. Open the `Docker QuickStart Terminal`. After VirtualBox starts in the terminal navigate to the app's folder.

3. Run the commands listed in `node.dockerfile` (see the comments at the top of the file) in the `Docker QuickStart Terminal`.

4. Navigate to http://192.168.99.100:8080 in your browser to view the site. This assumes that's the IP assigned to VirtualBox - change if needed.

##To run the app with Node.js and MongoDB (without Docker):

1. Install and start MongoDB (https://docs.mongodb.org/manual/installation).

2. Install Node.js (http://nodejs.org).

3. Open `config/config.development.json` and adjust the host name to your MongoDB server name (`localhost` normally works if you're running locally).

4. Run `npm install`.

5. Run `node dbSeeder.js` to get the sample data loaded into MongoDB. Exit the command prompt.

6. Run `node server.js` to start the server.

7. Navigate to http://localhost:8080 in your browser.

---

# Commands needed to run :

First create image from source:

    Build: docker build -f node.dockerfile -t so0oshiance/node .

# Option 1

Start MongoDB and Node (link Node to MongoDB container with legacy linking)

    docker run -d --name my-mongodb mongo

    docker run -d -p 3000:3000 --link my-mongodb:mongodb --name nodeapp so0oshiance/node

- my-mongodb:mongodb => mongodb is an alias in the node container we choose. You can see it in config>config.development.js file

# Option 2: Create a custom bridge network and add containers into it

     docker network ls

     docker network create --driver bridge isolated_network

    docker network ls

     docker run -d --net=isolated_network --name mongodb mongo

--name mongodb : Means link to this container with nogodb

- Now we can check if our container is added or not

# commands:

    docker network inspect [network Id]

    docker run -d --net=isolated_network --name nodeapp -p 3000:3000 so0oshiance/node

# Seed the database with sample database

     docker exec nodeapp node dbSeeder.js

- With exec you can run command in specific container with its name or id [nodeapp or 71]
