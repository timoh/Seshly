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

function fetch_locations(query) {
	$.ajax('/locations.json', {
		data: { name: query },
		cache: false, 
		success: function(results) {
			console.log(results[0].name);
			for (result in results) {
				$('#location-search-submit').after(result.name);	
			}
			
		}
	});
}		

function add_location_search() {
	$('#add-location').slideUp('slow');
	$('#add-location').after('<input type="text" id="location-query" placeholder="search for a location"></input><a href="/" class="btn btn-success" id="location-search-submit">Search</a>');
	$('#location-search-submit').click(function(e){
		e.preventDefault();
		query = $('#location-query').val();
		fetch_locations(query);
	});	
}