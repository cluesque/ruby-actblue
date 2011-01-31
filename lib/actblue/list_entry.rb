module ActBlue
  
  class ListEntry
    include ActiveBlue
    
    set_xml_name 'listentry'
    add_attributes ['page','entity','position']
    add_elements   ['blurb']
    
  end
  
end