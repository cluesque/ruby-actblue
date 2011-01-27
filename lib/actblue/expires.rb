module ActBlue
  
  class Expires
    include ActiveBlue
    
    XML_NAME   =  'expires'
    add_attributes  ['year', 'month']
    
  end
  
end