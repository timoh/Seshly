jQuery(document).ready(function() {


	//setup new centerpoint for map
    var latlng = new google.maps.LatLng(60.17, 24.93);

	//setup the map
    var myOptions = {
      zoom: 10,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

	//initialize map with prior settings
    var map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);

		//get-parameters
	function getParameterByName(name)
		{
		  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
		  var regexS = "[\\?&]" + name + "=([^&#]*)";
		  var regex = new RegExp(regexS);
		  var results = regex.exec(window.location.href);
		  if(results == null)
		    return "";
		  else
		    return decodeURIComponent(results[1].replace(/\+/g, " "));
		}

	//prepare for getJSON request
	var request_data = null;
	var request_base = '/locations.json';
	var request_arguments = '';

	//build request arguments
	if (getParameterByName('category')) {
		request_arguments = '/?category='+getParameterByName('category');
	}

	var request_target = request_base+request_arguments;

	jQuery.getJSON(request_target, request_data , function(data){
		jQuery.each(data, function(i, object) {
			
			console.log(object);

			var spotLatLng = new google.maps.LatLng(object.lat,object.lng);
			
			var spot_title = object.name;
			
			if (spot_title.length == 0) {
				spot_title = 'Untitled location';
			}
			
			var spot_desc = object.description;

			if (spot_title && spot_desc) {
				var contentString = '<div class="bubble" id="content"><h1>'+spot_title+'</h1>'+
				'<p>'+spot_desc.substring(0, 30)+'...</p><p><a href="spots/'+object._id+'">View details..</a></p></div>';
			
				
			} else {
				var contentString = '<div class="bubble" id="content"><h1>'+spot_title+'</h1>'+
				'<p><p><a href="locations/'+object._id+'">View details..</a></p></div>';
			}
			
			var infowindow = new google.maps.InfoWindow({
		        	content: contentString
		    });

			var marker = new google.maps.Marker({
		      position: spotLatLng, 
		      map: map,
		      title: spot_title
		  });

		google.maps.event.addListener(marker, 'click', function() {

			infowindow.open(map,marker);
			var newCenter = marker.getPosition();
			map.setCenter(newCenter);

	    });

		google.maps.event.addListener(map, 'click', function() {
			infowindow.close(map,marker);
		});

		google.maps.event.addListener(map, 'dragstart', function() {
			infowindow.close(map,marker);
		});

		})
	});



});