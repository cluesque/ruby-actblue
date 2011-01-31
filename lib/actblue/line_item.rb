module ActBlue
  
  class LineItem
    include ActiveBlue
    
    set_xml_name 'lineitem'
    add_attributes ['id','effective-at', 'status', 'visibility']
    add_elements   ['amount', 'fee', 'entity', 'aq-fee', 'premium-fee', 'processing-fee', 'jurisdiction']
    
  end
  
end