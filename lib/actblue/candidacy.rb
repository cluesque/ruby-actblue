module ActBlue
  
  class Candidacy 
    include ActiveBlue
    
    XML_NAME   =  'candidacy'
    add_attributes  ['id']
    add_elements    ['election','result']
    
  end
  
end