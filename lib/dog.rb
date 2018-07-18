class Dog
attr_accessor :name, :breed

  def initialize(attributes)
    attributes.each {|k,v| self.send(("#{k}="), v)}
  end













end
