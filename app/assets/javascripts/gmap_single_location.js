console.log('gmap_single_location loaded');

jQuery(document).ready(function($) {

	var locationId = $('#single_location').attr('location_id');
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
	
	$.ajax('/locations/'+locationId+'.json', {
		cache: false, 
		success: function(results) {
			singleLatLng = new google.maps.LatLng(results.lat, results.lng);
			drawMap(singleLatLng);
		}
	});
	
});


