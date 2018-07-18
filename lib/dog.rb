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

  def self.create(name:,breed:)
  end









end
