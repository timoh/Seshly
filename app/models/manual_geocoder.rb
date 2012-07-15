class ManualGeocoder
  
  def self.geocode_full(query)
    
    results = Array.new
    result_str = String.new
    
    street_address = self.geocode_field(query, 'street_address')
    street_number = self.geocode_field(query, 'street_number')
    
    unless street_address
      street_address == nil
    else
      
      # street_number should not be it's own element in an array to avoid commas
      if street_number
        street_address = street_address + ' ' + street_number
      end
      
      results << street_address
    end
    
    
    unless 
      street_number == nil
    else
      results << street_number
    end
    
    city = self.geocode_field(query, 'city')
    unless city
      city == nil
    else
      results << city
    end
    
    result_str = results.join(", ")
      
    return result_str.to_s
      
    
  end
  
  
  # ManualGeocoder.geocode_field(query, field_name)
  #
  # accepts array of coordinates and a specific field name, 
  # returns a string of an address component value 
  # example: {:type => 'street_address', :value => 'Tähtitorninkatu'} etc. 
  # 
  # OR IF NO RESULTS
  #
  # returns false
  
  def self.geocode_field(query, field_name)
    
    results = self.geocode(query)
    
    result_str = ""
    
    results.each do |result|
      #if result.length > 0
      if result[:type] == field_name
        result_str = result[:value]
      end
    end
    
    if result_str.length > 0
      return result_str.to_s
    else
      return false
    end
    
  end
  
  
  # ManualGeocoder.geocode(query)
  #
  # accepts array of coordinates, 
  # returns an array of hashes of address results 
  # example: {:type => 'street_address', :value => 'Tähtitorninkatu'} etc. 
  # 
  # OR IF NO RESULTS
  #
  # returns false
  
  def self.geocode(query)
    
    # Use the actual geocoder
    results = Geocoder.search(query).first.data
    results = results['address_components']
    res_array = Array.new
    
    # iterate through each address component, create an array of results
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
      
      # create hash out of type and value, push it to the results array
      hash = {:type => type, :value => value}
      res_array.push hash
      
    end
    
    # deliver finisher array of results, otherwise returns false
    if res_array.length > 0
      return res_array
    else
      return false
    end
    
  end

end
