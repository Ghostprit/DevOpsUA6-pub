FROM alpine:latest AS builder
WORKDIR /app
COPY package.json package-lock.json ./
COPY server.js ./
RUN apk add --no-cache nodejs npm
RUN npm install
COPY . ./
EXPOSE 3000

FROM node:18-alpine AS final
WORKDIR /app
COPY --from=builder /app /app
CMD ["node", "server.js"]