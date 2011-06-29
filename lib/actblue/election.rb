module ActBlue
  
  class Election
    include ActiveBlue
    
    add_attributes ['id']
    add_elements    ['election_date','office']
    
  end
  
end