$:.unshift(File.dirname(__FILE__)) unless 
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require "cecelia/version"
require "cecelia/graph"

#module Cecelia
#end
#

class Cecelia
  def initialize(db_name)
    Graph.new(db_name)
  end
end
