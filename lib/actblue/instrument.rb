module ActBlue
  
  class Instrument
    include ActiveBlue
    
    add_elements ['creditcard', 'check']
    
  end
  
end