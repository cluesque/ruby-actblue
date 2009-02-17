module ActBlue 
  
  class Contribution < ActiveBlue
    
    XML_NAME = 'contribution'
    ATTRIBUTES = ['order-number', 'created-on']
    ELEMENTS = ['refcode', 'source', 'timestamp', 'submitter', 'recurring', 'recurringtimes', 'referrer', 'successuri', 'lineitems']

    def self.get(params)
      hash = ActiveBlue.get('/contributions', :query => params)
      result = []
      if hash["contributions"]
        hash["contributions"]["contribution"].each do |h|
            result << Contribution.new(h)
        end
      elsif hash["contribution"]
        result << Contribution.new(hash["contribution"])
      end
      result
    end
    
    def post
      super.post('/contributions', :body => to_xml)
    end
    
    def put
      super.put('/contributions', :body => to_xml)
    end

  end
  
end