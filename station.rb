

class Station
  attr_accessor :trains, :name

  def initialize(name)
   @name = name
   @trains = []
  end

  def add_train(train)
  @trains << train
  end

  def delete_train(train)
  @trains.delete(train)
  end


  def train_type(type)
    @trains.select {|train| train.type == type}.count
  end
end





