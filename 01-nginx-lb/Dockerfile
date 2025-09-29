FROM node:alpine

#RUN addgroup -S appuser && \
#adduser -S -u 1000 appuser -G appuser

WORKDIR /app

COPY package.json .

RUN npm install

COPY --chown=node:node . .

USER node

EXPOSE 3000

CMD ["node", "server.js"]
