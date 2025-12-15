FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN apk add --no-cache nodejs npm
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:alpine AS final
COPY --from=builder /app/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]