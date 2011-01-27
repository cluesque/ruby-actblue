
module ActBlue
  
  ACTBLUE_VERSION = "2007-10-1"
  ACTBLUE_URL = ENV['ACTBLUE_URL'] || "https://secure.actblue.com"
  
  class ActiveBlue
    include HTTParty
    format :xml
    base_uri "#{ACTBLUE_URL}/#{ACTBLUE_VERSION}"
    basic_auth ENV['ACTBLUE_USER'], ENV['ACTBLUE_PASS'] if (ENV['ACTBLUE_USER'] && ENV['ACTBLUE_PASS'])
    headers 'Accept' => 'application/xml'
    
    attr_accessor :variables
    
    def line_items_lambda 
      lambda do |hash| 
        if (hash.is_a?(Array) && hash.first.class.name == "ActBlue::LineItem") 
          return hash 
        else
          collection = [] 
          if hash['lineitem'].is_a?(Hash) 
            collection << LineItem.new(hash['lineitem'])
          else 
            hash['lineitem'].each {|l| collection << LineItem.new(l); }
          end
          return collection
        end
      end
    end 
    
    def listentries_lambda 
      lambda do |hash| 
        if (hash.is_a?(Array) && hash.first.class.name == "ActBlue::ListEntry")
           return hash 
        else 
          collection = []
          if hash['listentry'].is_a?(Hash)
            collection << ListEntry.new(hash['listentry'])
          else 
            hash['listentry'].each {|l| collection << ListEntry.new(l); }
          end 
          return collection
        end
      end
    end
  
    def act_types 
      {
        'source' => ActBlue::Source, 
        'page' => ActBlue::Page, 
        'lineitem' => ActBlue::LineItem, 
        'lineitems' => line_items_lambda,
        'entity' => ActBlue::Entity, 
        'instrument' => ActBlue::Instrument, 
        'election' => ActBlue::Election,
        'expires' => ActBlue::Expires,
        'listentry' => ActBlue::ListEntry,
        'listentries' => listentries_lambda,
        'check' => ActBlue::Check,
        'creditcard' => ActBlue::CreditCard,
        'candidacy' => ActBlue::Candidacy,
        'office' => ActBlue::Office
      }
    end
  
    def initialize(params = {})      
      @variables = {}
      params.each do |key, value|  
        if value
          if act_types[key.to_s] && act_types[key.to_s].is_a?(Proc)
            collection = []
            collection = act_types[key.to_s].call(value) if !value.empty?
            @variables[key.to_s] = collection
          elsif act_types[key.to_s] && value.is_a?(Hash)
            @variables[key.to_s] = act_types[key.to_s].new(value)
          else  
            @variables[key.to_s] = value
          end
        end
      end
    end
  
    def [](key)
      @variables[key]
    end
  
    def []=(key, val)
      @variables[key] = val
    end
    
    def to_xml
      doc = REXML::Document.new
      doc.add_element(to_xml_element)
      output = ""
      doc.write(output)
      output
    end
    
    def to_xml_element
      element = REXML::Element.new(self.class::XML_NAME)
      self.class::ATTRIBUTES.each do |a|
        element.add_attribute(a, @variables[a]) if @variables[a]
      end
      self.class::ELEMENTS.each do |e|
        if @variables[e]
          if act_types[e] && act_types[e].is_a?(Proc)
            parentElement = REXML::Element.new(e)
            @variables[e].each do |c|
              if c.respond_to? :to_xml_element
                parentElement.add_element(c.to_xml_element)
              end
            end
            element.add_element(parentElement)
          else
            if @variables[e].respond_to? :to_xml_element
              element.add_element(@variables[e].to_xml_element)
            else
              newElement = REXML::Element.new(e)
              newElement.text = @variables[e]
              element.add_element(newElement)
            end
          end
        end
      end
      element
    end
    
  end
  
end
