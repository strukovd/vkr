const {mainController} = require('../controllers/mainController');
const {formController} = require('../controllers/formController');
const {send} = require('../controllers/send');


exports.init = function(app){

	app.get('/', mainController);
	app.get('/form/:id', formController);
	app.post('/send/:id', send);


	// 404
	app.use(function(req, resp, next){
		resp.status(404).render("service/404.hbs", {});
	});

};
