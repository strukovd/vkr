exports.createSuccessResponse = function(data) {
	return {
		success:true,
		data:data
	};
};

exports.createFailedResponse = function(error, code) {
	let resp = {
		success:false,
		error: {
			desc: error
		}
	};

	if(code != undefined) {
		resp.error['code'] = code;
	}

	return resp;
};