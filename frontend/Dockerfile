FROM node:20-alpine

WORKDIR /app

COPY package.json ./
RUN npm install

COPY index.js app.js index.html styles.css ./

EXPOSE 8081

CMD ["npm", "start"]
