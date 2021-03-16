FROM node as dev
WORKDIR /opt/app
COPY package.json .
RUN npm i
COPY . .

RUN npm run build


###########################################
# package up only the app
###########################################
FROM bitnami/nginx:1.16

COPY nginx_server_block.conf /opt/bitnami/nginx/conf/server_blocks/nginx_server_block.conf
WORKDIR /app

# use dist from previous stage
COPY --from=dev /opt/app/dist/ .
