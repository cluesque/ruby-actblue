module ActBlue
  
  class Check 
    include ActiveBlue
    
    XML_NAME   =  'check'
    add_attributes  ['id']
    add_elements    ['date', 'number']
    
  end
  
end