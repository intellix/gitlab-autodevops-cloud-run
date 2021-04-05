FROM node:12 as build

WORKDIR /app
RUN npm config set unsafe-perm true
COPY package.json package*.json ./
COPY patches ./patches
RUN npm ci
COPY . .
RUN npm run build

FROM node:12-slim as run
WORKDIR /app
COPY --from=build ["/app", "./"]
CMD ["sh", "-c", "npm run start"]
