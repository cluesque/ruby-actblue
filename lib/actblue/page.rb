module ActBlue
  
  class Page 
    include ActiveBlue
    
    XML_NAME   =  'page'
    add_attributes  ['name', 'partner', 'created-on']
    add_elements    ['title', 'author', 'blurb', 'visibility', 'showcandidatesummary', 'listentries']
    
    def post
      ActiveBlue.post('/pages', :body => to_xml)
    end
    
    def put
      ActiveBlue.put("/pages/#{@variables['name']}", :body => to_xml) if @variables['name']
    end
    
    def delete
      @variables['visibility'] = "archived"
      ActiveBlue.put("/pages/#{@variables['name']}", :body => to_xml) if @variables['name']
    end
    
    def self.get(name)
      hash = ActiveBlue.get("/page/#{name}", :base_uri => ACTBLUE_URL)
      if hash.response.code == '200'  
        Page.new hash['page']
      else
        return nil
      end
    end
    

  end
  
end