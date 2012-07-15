jQuery(document).ready(function($) {

console.log('gmap_single_location loaded');
  
	var locationId = $('#single_location').attr('location_id'); // if using FQsq Location

  var u_latitude = parseFloat($('#single_location').attr('latitude')); // if using pure coordinates
	var u_longitude = parseFloat($('#single_location').attr('longitude'));

	var singleLatLng = new google.maps.LatLng(0.0, 0.0);

	function drawMap(LatLng){
	    var myOptions = {
	      zoom: 14,
	      center: LatLng,
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    };
	
		//initialize map with prior settings			
    var map = new google.maps.Map(document.getElementById("single_location"), myOptions);
	
	  //set the marker
		var marker = new google.maps.Marker({
			position: LatLng, 
			map: map
		});
	}
	
	function fetchLocation(){
	  $.ajax('/locations/'+locationId+'.json', {
  		cache: false, 
  		success: function(results) {
  			singleLatLng = new google.maps.LatLng(results.lat, results.lng);
  			drawMap(singleLatLng);
  		}
  	});
	}
	
	
	// main function
	
	if(locationId){
  	fetchLocation();
	} else {
	  singleLatLng = new google.maps.LatLng(u_latitude, u_longitude);
	  drawMap(singleLatLng);
	}
	
});



