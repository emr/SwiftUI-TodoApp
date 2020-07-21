FROM node:14.5-alpine
WORKDIR /var/www/app
COPY . .
RUN yarn
EXPOSE 80
CMD ["yarn", "start:dev"]
