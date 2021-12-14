FROM node:16-slim as build

ENV LANG ja_JP.UTF-8
ENV LC_TIME C


WORKDIR /app

RUN apt-get update && apt-get install -y openssl

COPY package.json yarn.lock ./
RUN yarn install --non-interactive --frozen-lockfile

COPY . .
#RUN npx prisma generate
RUN yarn build
RUN ls dist/

#=======================================================
# Package install
FROM node:16-slim as node_modules

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --non-interactive --frozen-lockfile --prod
#=======================================================
# Run
FROM node:16-slim

WORKDIR /app

ENV NODE_ENV=production

RUN apt-get update && apt-get install -y openssl curl

COPY --from=build /app/dist /app/dist
COPY --from=node_modules /app/node_modules /app/node_modules

EXPOSE 3000
CMD ["node", "dist/main"]
