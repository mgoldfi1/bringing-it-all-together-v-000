require 'pry'
class Dog
attr_accessor :name, :breed, :id

  def initialize(attributes, id=nil)
    attributes.each {|k,v| self.send(("#{k}="), v)}
    @id = id
  end

  def self.create_table
  DB[:conn].execute("CREATE TABLE IF NOT EXISTS dogs(id INTEGER PRIMARY KEY, name TEXT, breed TEXT)")
  end

  def self.drop_table
  DB[:conn].execute("DROP TABLE dogs")
  end

  def save
   sql = <<-SQL
   INSERT INTO dogs (name, breed) VALUES (?,?)
   SQL
   if self.id
      self.update
   else
   DB[:conn].execute(sql, self.name, self.breed)
   @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
  self
  end

  def self.create(attributes)
    dog = Dog.new(attributes)
    dog.save
    dog
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    result = DB[:conn].execute(sql, id)[0]
    attributes = {name: result[1], breed: result[2]}
    dog = Dog.new(attributes, id= result[0])
    # binding.pry
    dog
  end

  def self.find_or_create_by(name:,breed:)
    sql = "SELECT * FROM dogs WHERE name = ? AND breed = ?"
    result = DB[:conn].execute(sql, name, breed)
    dog = result[0]
    binding.pry
    attributes = {name: dog[1], breed: dog[2]}
    if !result.empty?
        doggie = Dog.new(attributes, id = dog[0])
    else
      doggie = self.create(attributes)
    end
    doggie
    #binding.pry

  end








end
