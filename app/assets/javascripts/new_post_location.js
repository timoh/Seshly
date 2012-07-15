console.log('new_post_location loaded');

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

function fetch_venues(query, access_token) {
	$.ajax('/venues.json', {
		data: { location: query, access_token: access_token },
		cache: false, 
		success: function(results) {
			console.log(results);
			for (i=0; i<results.length; i++ ) {
				$('#location-results').append('<li class="location-selector"><a href="#" id="'+results[i].json.id+'">'+results[i].json.name+', '+results[i].json.location.address+'</a></li>')	
			}
			
		}
	});
}

function fetch_locations() {
	$.ajax('/locations.json', {
		cache: false, 
		success: function(results) {
			console.log(results);
			for (i=0; i<results.length; i++ ) {
				$('#location-results').append('<li class="location-selector"><a href="#" id="'+results[i].json.id+'">'+results[i].json.name+', '+results[i].json.location.address+'</a></li>')	
			}
			
		}
	});
}

function hilight_active(){
	e.preventDefault();
	$('.location-selector').removeClass('active');
	$(this).addClass('active');
}

function remember_selection(selection){
	kyseinen = $(selection).attr('id');
	$('#foursquare_id').val(kyseinen);
}

function handle_location_selection(){
	$('#location-results').on("click", ".location-selector a", function(e){
		e.preventDefault();
		$('.location-selector').removeClass('active');
		$(this).addClass('active');
		fetch_locations();
		remember_selection(this);
		hilight_active();
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
		access_token = $('#access_token-field').val();
		fetch_venues(query, access_token);
		handle_location_selection();
	});	
}