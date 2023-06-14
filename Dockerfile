FROM node:16-alpine as builder
#different from vidoe, just copied the changes i had to make earlier on in the .dev file
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

#no move over phase needed here, the next FROM statement simply marks a new start

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
