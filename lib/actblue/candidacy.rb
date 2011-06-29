module ActBlue
  
  class Candidacy 
    include ActiveBlue
    
    add_attributes  ['id']
    add_elements    ['election','result']
    
  end
  
end