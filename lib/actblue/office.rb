module ActBlue
  
  class Office
    include ActiveBlue
    
    add_attributes  ['id']
    add_elements    ['name','description','race_type','district','seat_count','state']
    
  end
  
end