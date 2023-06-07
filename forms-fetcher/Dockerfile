FROM node:14

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# COPY package*.json ./
# RUN npm install
COPY . .

ENV TZ=Asia/Bishkek
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# EXPOSE 58588

CMD [ "node", "app.js" ]