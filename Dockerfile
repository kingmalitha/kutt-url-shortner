FROM node:22-alpine

ENV NODE_ENV=production

WORKDIR /kutt

RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

RUN mkdir -p /var/lib/kutt

# Install AWS CLI
RUN apk update && apk add --no-cache aws-cli

# Create a script to fetch parameters and start the app
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

COPY . .

EXPOSE 3000

ENTRYPOINT ["/docker-entrypoint.sh"]

# Remove this CMD line, as ENTRYPOINT is now handling startup
#CMD npm run migrate && npm start
