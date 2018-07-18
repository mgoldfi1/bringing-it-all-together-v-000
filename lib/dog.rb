class Dog
attr_accessor :name, :breed, :id

  def initialize(attributes, id=nil)
    attributes.each {|k,v| self.send(("#{k}="), v)}
    @id = id
  end

  def self.create_table
  DB[:conn].execute("CREATE TABLE IF NOT EXISTS dogs(id INTEGER PRIMARY KEY, name TEXT, breed TEXT)")











end
