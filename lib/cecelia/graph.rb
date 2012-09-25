require 'sequel'
require 'yaml'

class Graph
  def initialize(db_name = "sqlite:/")
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
      begin
        source_id = Vertices.find(:label => source)[:id]
        target_id = Vertices.find(:label => target)[:id]
      rescue => exc
         exc
      ensure
        add_edge_id(source_id, target_id, attributes = {})
      end
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
    dataset = nil
    if id.class == Integer
      dataset = Edges.filter(:source => id).all
    elsif id.class == String
      label = Vertices.find(:label => id)[:id]
      dataset = Edges.filter(:source => label).all
    end
    dataset
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

  def remove_vertex(label)
    if label.class == String 
      Vertices.find(:label => label).delete
    end
  end

  def remove_edge(id)
    id = id.to_i  
    Edges.find(:id => id).delete
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


