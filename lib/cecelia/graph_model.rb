require 'sequel'

class GraphModel
  def initialize(db_name)
    DB = Sequel.sqlite(db_name)
    Sequel::Model.plugin(:schema)
  end
  
  class Vertices < Sequel::Model
    unless table_exists?
      set_schema do
        primary_key :id, :autoincrement => true
        string :attributes
      end
      create_table
    end
  end

  class Edges < Sequel::Model
    unless table_exists?
      set_schema do 
        primary_key :id, :autoincrement => true
        integer :source
        integet :target
        string :attributes
      end
      create_table
    end
  end
end
