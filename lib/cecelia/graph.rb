require 'cecelia/graph_model.rb'

class Graph
  def initialize
  end

  def add_vertex (attributes="")
    Vertices.create(:attributes => attributes)
  end

  def add_edge(source,target,attributes="")
    unless Vertices.find(:id => source) == nil && Vertices.find(:id => target) == nil
      if ((Edges.filter(:source => source).filter(:target => target)).all).empty?
        Edges.create(:source => source, :target => target, :attributes => attributes)
      end
    end
  end

  def verticies
    Vertices.all
  end

  def edges
    Edges.all
  end

  def neighbors(id)
    Edges.filter(:source => id).all
  end
end
