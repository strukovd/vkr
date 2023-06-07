const MongoClient = require("mongodb").MongoClient;
const config = //require("./volume/fake_auth/config/config.json");
{
	"MONGO_USER" : "admin",
	"MONGO_PASSWORD" : "password",
	"MONGO_URL" : "mongodb://localhost:27017",
	"MONGO_DB_NAME" : "forms"
};

const DB_PARAMS =
{
	user : config.MONGO_USER, //admin
	password: config.MONGO_PASSWORD, //password
	useNewUrlParser: true,
	// autoReconnect : true,
	// reconnectTries : 9999999999,
	// reconnectInterval : 1000,
	useUnifiedTopology : true
};

exports.getConnection = async function(url) {
	const conn = await MongoClient.connect( config.MONGO_URL, DB_PARAMS );
	return conn;
};


exports.getDB = async function(db_name=config.MONGO_DB_NAME, mongo_url=config.MONGO_URL) {
	const conn = await exports.getConnection(mongo_url);
	return { db: conn.db(config.MONGO_DB_NAME), conn: conn };
};


exports.getCollection = async function(collection_name, db_name=config.MONGO_DB_NAME, mongo_url=config.MONGO_URL) {
	const {db, conn} = await exports.getDB(db_name, mongo_url);
	return { db: conn.db(config.MONGO_DB_NAME), conn: conn, collection: db.collection(collection_name) };
};


// exports.connection = exports.client = client;


// if (client)
// {
// 	const db = client.db(config.MONGO_DB_NAME);
// 	const collection = db.collection(COLLECTION_NAME);
// 	const res = await collection.findOne( {refId:'4abpnBeIzGF2nv87EaD4mm'} );
// 	console.log(res);
// }




exports.insertOne = async function( value, collection_name, db_name=config.MONGO_DB_NAME ) {
	const {db, conn, collection} = await exports.getCollection(collection_name, db_name);
	await collection.insertOne(value);
	await conn.close();

	// const res = await collection.findOne( {refId:'4abpnBeIzGF2nv87EaD4mm'} );
};



exports.findOne = async function( value, collection_name, db_name=config.MONGO_DB_NAME ) {
	const {db, conn, collection} = await exports.getCollection(collection_name, db_name);
	const res = await collection.findOne( value );
	await conn.close();
	return res;
};


// exports.find = async function( value, collection_name=COLLECTION_NAME, db_name=DB_NAME )
// {
// 	const {db, conn, collection} = await exports.getCollection(collection_name, db_name);
// 	const res = await collection.find( value );
// 	conn.close();
// }

