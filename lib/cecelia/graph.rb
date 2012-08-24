require 'sequel'
require 'yaml'

class Graph
  def initialize(db_name)
    @db = Sequel.connect(db_name)
    require 'cecelia/graph_model.rb'
  end

  def add_vertex (label = "", attributes = {})
    if Vertices.find(:label => label) == nil
      Vertices.create(:label=> label, :attributes => YAML.dump(attributes))
    end
  end

  def add_edge(source, target, attributes = {})
    if source.class == String && target.class == String
      source_id = Vertices.find(:label => source)[:id]
      target_id = Vertices.find(:label => target)[:id]
      add_edge_id(source_id, target_id, attributes = {})
    else
      add_edge_id(source, target, attributes = {})
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

  def find_vertex(args = {})
    Vertices.find(args)
  end
  
  def find_edge(args = {})
    Edges.find(args)
  end

  def filter_vertex(args = {})
    Vertices.filter(args)
  end

  def filter_edge(args = {})
    Edges.filter(args)
  end

  private
  def add_edge_id(source, target, attributes = {})
    unless Vertices.find(:id => source) == nil && Vertices.find(:id => target) == nil
      if ((Edges.filter(:source => source).filter(:target => target)).all).empty?
        Edges.create(:source => source, :target => target, :attributes => YAML.dump(attributes))
      end
    end
  end
end


