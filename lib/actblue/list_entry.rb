module ActBlue
  
  class ListEntry
    include ActiveBlue
    
    XML_NAME   =  'listentry'
    add_attributes ['page','entity','position']
    add_elements   ['blurb']
    
  end
  
end