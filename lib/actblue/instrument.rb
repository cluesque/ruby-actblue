module ActBlue
  
  class Instrument
    include ActiveBlue
    
    XML_NAME = 'instrument'
    add_elements ['creditcard', 'check']
    
  end
  
end