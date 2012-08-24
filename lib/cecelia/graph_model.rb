require 'sequel'

Sequel::Model.plugin(:schema)

class Vertices < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id, :autoincrement => true
      string :label
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
