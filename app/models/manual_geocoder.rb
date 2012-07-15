class ManualGeocoder

  def self.geocode(query)
    
    results = Geocoder.search(query).first.data
    
    results = results['address_components']
    
    res_array = Array.new
    results.each do |result|
      
      hash = Hash.new
      
      type = result['types'][0]
      
      type = case type
        when 'route' then 'street_address'
        when 'sublocality' then next
        when 'locality' then 'city'
        when 'administrative_area_level_3' then 'city'
        when 'administrative_area_level_2' then next
        when 'administrative_area_level_1' then 'state'
        else type
      end
      
      value = case result['long_name']
        
        when 'False' then next
        
        else result['long_name']
      end
      hash = {:type => type, :value => value}
      
      res_array.push hash
      
    end
    
    return res_array
  end

end
