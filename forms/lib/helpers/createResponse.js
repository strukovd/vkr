exports.createSuccessResponse = function(data) {
	return {
		success:true,
		data:data
	};
};

exports.createFailedResponse = function(error) {
	return {
		success:false,
		error:error
	};
};