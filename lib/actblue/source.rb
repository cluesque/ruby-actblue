module ActBlue
  
  class Source 
    include ActiveBlue
    
    add_elements   ['firstname', 'lastname', 'addr1', 'addr2', 'city', 'state', 'zip', 'country', 'employer', 'occupation', 'empaddr1', 'empaddr2', 'empcity', 'empstate', 'empzip', 'empcountry', 'email', 'phone']
    
  end
  
end