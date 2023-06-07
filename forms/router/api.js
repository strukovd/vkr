const multer = require('multer');
const upload = multer({ dest: `${global.storagePath}/uploads/` });

const {getCities} = require('../controllers/api/getCities');
const {getRegions} = require('../controllers/api/getRegions');
const {getDistricts} = require('../controllers/api/getDistrict');
const {getStreets} = require('../controllers/api/getStreets');
const {getPassportSeries} = require('../controllers/api/getPassportSeries');
const {getFile} = require('../controllers/api/getFile');
const {getFileListByFormKey} = require('../controllers/api/getFileListByFormKey');
const {getBuildingTypes} = require('../controllers/api/getBuildingTypes');
const {getSectorTypes} = require('../controllers/api/getSectorTypes');

const {uploadFile} = require('../controllers/api/uploadFile');



exports.init = function(app, apiRouter) {

	apiRouter.get('/getRegions', getRegions);
	apiRouter.get('/getDistricts', getDistricts);
	apiRouter.get('/getCities', getCities);
	apiRouter.get('/getStreets', getStreets);
	apiRouter.get('/getPassportSeries', getPassportSeries);
	apiRouter.get('/getBuildingTypes', getBuildingTypes);
	apiRouter.get('/getSectorTypes', getSectorTypes);
	apiRouter.post('/getFile', getFile);
	apiRouter.post('/getFileListByFormKey', getFileListByFormKey);

	apiRouter.post('/uploadFile', upload.single('file'), uploadFile);

	app.use(`/api`, apiRouter);

	// 404
	// app.use(function(req, resp, next){
	// 	resp.status(404).render("service/404.hbs", {});
	// });
};
