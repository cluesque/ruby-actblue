module ActBlue
  
  class Entity
    include ActiveBlue
    
    add_attributes  ['id']
    add_elements    ['legalname', 'displayname', 'sortname', 'jurisdiction', 'govid', 'prefacewiththe', 'donate', 'kind', 'state', 'party', 'url', 'visible','candidacies', 'pages']

    def self.get(id)
      hash = ActiveBlue.get("/entity/fundraisers/#{id}", :base_uri => ACTBLUE_URL)
      if hash.response.code == '200'
        Entity.new hash['entity']
      else
        return nil
      end
    end
  end
  
end