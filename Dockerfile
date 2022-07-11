ARG NODE_VERSION=14.19.1

###
# DEVELOPMENT IMAGE
#
# This image has no code baked in since the code will be mounted into it
# by docker-compose.
###

# Locking to a specific version to avoid version compatibility issues
FROM node:${NODE_VERSION} as development

# set node user's UID
ARG NODE_UID=1000
RUN groupmod -g "${NODE_UID}" node && usermod -u "${NODE_UID}" -g "${NODE_UID}" node

# Set to a non-root built-in user `node`
USER node
ENV HOST=0.0.0.0 PORT=8080
EXPOSE ${PORT}

###
# BUILDER IMAGE
#
# This builds upon the development image, installs modules, and
# builds the code
###

FROM development as builder

# Create app directory (with user `node`)
RUN mkdir -p /home/node/app

WORKDIR /home/node/app

# Install app dependencies
COPY --chown=node package.json yarn.lock ./

RUN yarn install

# Bundle app source code
COPY --chown=node . .

RUN yarn run build

# Google's Error Reporting requires a NODE_ENV variable set to production
ENV NODE_ENV="production"

CMD [ "node", "dist/main" ]
