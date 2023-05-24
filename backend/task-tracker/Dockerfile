FROM node:18 as node

WORKDIR /usr/src/app

COPY . .
RUN npm i
RUN npm run build

ENV TZ=Asia/Bishkek
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["npm", "run start:prod"]
