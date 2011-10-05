module Mapper
  def self.mapping_fields(result_array)
    output_hash = Hash.new
    output_hash['Name'] = result_array[0]
    output_hash['AccountNumber'] = result_array[1]
    output_hash['PAR121__parId__c'] = result_array[2]
    output_hash
        
  end
end


#mapper.mapping_fields([1, "IKEA Investfast AB ", "5564094596", "1:200686583"])
