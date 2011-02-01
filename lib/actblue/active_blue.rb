
module ActBlue
  
  ACTBLUE_VERSION = "2007-10-1"
  ACTBLUE_URL = ENV['ACTBLUE_URL'] || "https://secure.actblue.com"
  
  module ActiveBlue
    include HTTParty
    format :xml
    base_uri "#{ACTBLUE_URL}/#{ACTBLUE_VERSION}"
    basic_auth ENV['ACTBLUE_USER'], ENV['ACTBLUE_PASS'] if (ENV['ACTBLUE_USER'] && ENV['ACTBLUE_PASS'])
    headers 'Accept' => 'application/xml'
    
    attr_accessor :variables
    
    # add accessors and other class methods places where this has been included 
    
    module ClassMethods
      def elements 
        @elements || []
      end 
      
      def attributes
        @attributes || []
      end

      def xml_name
        @xml_name ||= self.name.split('::').last.downcase
      end
      
      def add_attributes(attributes)
        @attributes = attributes
        setup_accessors(attributes) 
      end
      
      def add_elements(elements)
        @elements = elements
        setup_accessors(elements)
      end
      
      def setup_accessors(names)
        accessor_name_hash  = { }
        names.each do | key |
          accessor_name_hash[key.gsub('-', '_')] = key
        end
        
        accessor_name_hash.each do | accessor_name, variable_name|
          # assignment
          define_method "#{accessor_name}=".intern do | value |
            @variables[variable_name] = value
          end
          # access
          define_method accessor_name.intern do
            @variables[variable_name]
          end
        end
      end

      def set_xml_name(name)
        @xml_name = name
      end

    end
    
    def self.included(base)
      base.extend ClassMethods
    end
        
    def collection_lambda(clazz)
      lambda do |hash|
        if (hash.is_a?(Array) && hash.first.class == clazz)
          return hash 
        else
          collection = [] 
          if hash[clazz.xml_name].is_a?(Hash)
            collection << clazz.new(hash[clazz.xml_name])
          else 
            hash[clazz.xml_name].each {|l| collection << clazz.new(l); }
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
        'lineitems' => collection_lambda(ActBlue::LineItem),
        'entity' => ActBlue::Entity, 
        'instrument' => ActBlue::Instrument, 
        'election' => ActBlue::Election,
        'expires' => ActBlue::Expires,
        'listentry' => ActBlue::ListEntry,
        'listentries' => collection_lambda(ActBlue::ListEntry),
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
            @variables[key.to_s] = act_types[key.to_s].call(value) if !value.empty?
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
      element = REXML::Element.new(self.class.xml_name)
      self.class.attributes.each do |a|
        element.add_attribute(a, @variables[a]) if @variables[a]
      end
      self.class.elements.each do |e|
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

