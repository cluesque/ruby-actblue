module ActBlue
  
  class CreditCard 
    include ActiveBlue

    set_xml_name    'creditcard'
    add_elements    ['name', 'billing-addr1', 'billing-addr2', 'billing-city', 'billing-state', 'billing-postalcode', 'account', 'expires', 'verifier']
    
  end
  
end