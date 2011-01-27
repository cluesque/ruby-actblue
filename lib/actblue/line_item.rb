module ActBlue
  
  class LineItem
    include ActiveBlue
    
    XML_NAME = 'lineitem'
    add_attributes ['id','effective-at', 'status', 'visibility']
    add_elements   ['amount', 'fee', 'entity', 'aq-fee', 'premium-fee', 'processing-fee', 'jurisdiction']
    
  end
  
end