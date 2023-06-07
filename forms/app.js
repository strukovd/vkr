const express = require('express');
const hbs = require("hbs");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");

global.storagePath = `./storage`;

const config = global.config = require(`${global.storagePath}/config.json`);
const router = require('./router/router');
const apiRouter = require('./router/api');

const {registerHelpers} = require(`./lib/helpers/registerHelpers`);


//TODO: добавлять option по умолчанию "Не выбрано" при динамической загрузке и очистке
//TODO: в вып. списках "Не выбрано" сделать мульти-язычным

//TODO: переверстать адаптивно


//TODO: на потерю фокуса сохранять данные полей в локал-сторедж
//TODO: have_static_data => have_static_set
//TODO: добавить мультиязычность для подписей ошибок (Не заполненое поле и т.п.)

registerHelpers(hbs);

const app = express();
app.use(express.static(__dirname + "/public")); //Даем доступ к папке
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cookieParser());
app.set("view engine", "hbs");


//инициализируем роуты
apiRouter.init(app, express.Router());
router.init(app);

app.listen(config.PORT, () => {
	console.log(`Listening at http://localhost:${config.PORT}`);
});
