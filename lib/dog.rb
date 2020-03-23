class Dog 
  
  attr_accessor  :name, :breed 
  attr_reader :id
   
   def initialize(id: nil, name:, breed:)
     @id = id
     @name = name 
     @breed =  breed
   end 
     
   def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
      SQL

      DB[:conn].execute(sql)
    end
      
    def self.drop_table 
      sql = <<-SQL 
       DROP TABLE dogs 
     SQL
     DB[:conn].execute(sql)
    end   
      
    def self.new_from_db(row)  
      dog = self.new(row[1], row[2], row[0])
      dog 
    end   
      
    def self.find_by_name(name)
      sql = <<-SQL 
      SELECT * FROM dogs WHERE name = ? 
      SQL
      DB[:conn].execute(sql, name,).map do |row|
        self.new_from_db(row)
      end.first 
    end   
    
  end   