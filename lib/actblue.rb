require 'rubygems'
require 'net/https'
require 'cgi'
require 'httparty'
require 'rexml/document'

class REXMLUtilityNode
  def undasherize_keys(params)
    params
  end
end

require 'actblue/active_blue'
Dir["#{File.dirname(__FILE__)}/actblue/*.rb"].each { |source_file| require source_file }
