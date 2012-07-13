var latitude = "", longitude = "";

function post_values(latitude, longitude) {
	$('.control-group').append('<input type="hidden" name="post[latitude]" id="latitude" value="'+latitude+'"></input>');
	$('.control-group').append('<input type="hidden" name="post[longitude]" id="longitude" value="'+longitude+'"></input>');
}

function success(position) {
	latitude = position.coords.latitude;
	longitude = position.coords.longitude;
	latlng = latitude+', '+longitude
	$('h1').after('<div class="alert alert-info">Geotagging successful: <i>'+latlng+'</i>.</div>');
	post_values(latitude, longitude);
}	

function error(msg) {
  var s = document.querySelector('#status');
  s.innerHTML = typeof msg == 'string' ? msg : "failed";
  s.className = 'fail';

  // console.log(arguments);
}

function post_geolocate() {
	if (navigator.geolocation) {
	  	navigator.geolocation.getCurrentPosition(success, error);
	} else {
	  // error('not supported');
	}
}		
