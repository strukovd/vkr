# инструкция сборки образа (docker build)


# <имя образа:версия>
FROM node:14

# создание директории приложения
WORKDIR /usr/src/app

# установка зависимостей
# символ астериск ("*") используется для того чтобы по возможности
# скопировать оба файла: package.json и package-lock.json
COPY package*.json ./

RUN npm install
# Если вы создаете сборку для продакшн
# RUN npm ci --only=production

# копируем исходный код
COPY . .

# Контейнер слушает порт 3000
EXPOSE 8080

# Запускаем приложение
CMD [ "node", "app.js" ]