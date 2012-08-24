require 'sequel'
require 'yaml'

class Graph
  def initialize(db_name)
    @db = Sequel.sqlite(db_name)
    require 'cecelia/graph_model.rb'
  end

  def add_vertex (label = "", attributes => {})
    unless Vertices.find(:label => label) == nil
      Vertices.create(:label=> label, :attributes => YAML.dump(attributes))
    end
  end

  def add_edge(source, target, attributes => {})
    unless Vertices.find(:id => source) == nil && Vertices.find(:id => target) == nil
      if ((Edges.filter(:source => source).filter(:target => target)).all).empty?
        Edges.create(:source => source, :target => target, :attributes => YAML.dump(attributes))
      end
    end
  end

  def vertices
    Vertices.all
  end

  def edges
    Edges.all
  end

  def neighbors(id)
    Edges.filter(:source => id).all
  end
end
