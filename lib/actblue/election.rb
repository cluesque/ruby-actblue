module ActBlue
  
  class Election
    include ActiveBlue
    
    XML_NAME   =  'election'
    add_attributes ['id']
    add_elements    ['election_date','office']
    
  end
  
end