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
		data: { location: query },
		cache: false, 
		success: function(results) {
			for (i=0; i<results.length; i++ ) {
				$('#location-results').append('<li class="location-selector"><a href="#" id="'+results[i].foursq_id+'">'+results[i].name+'</a></li>')	
			}
			
		}
	});
}

function handle_location_selection(){
	$('#location-results').on("click", ".location-selector a", function(e){
		e.preventDefault();
		kyseinen = $(this).attr('id');
		$('#foursquare_id').val(kyseinen);
	});
}
		

function add_location_search() {
	$('#add-location').slideUp('slow');
	$('.control-group').append('<input type="hidden" name="post[foursquare_id]" id="foursquare_id" value=" "></input>');
	$('#add-location').after('<input type="text" id="location-query" placeholder="search for a location"></input><a href="/" class="btn btn-success" id="location-search-submit">Search</a><div id="location-results"></div>');
	$('#location-search-submit').click(function(e){
		e.preventDefault();
		query = $('#location-query').val();
		$('#location-results').html('');
		fetch_locations(query);
		handle_location_selection();
	});	
}