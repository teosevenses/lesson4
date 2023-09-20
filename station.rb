

class Station
  attr_accessor :trains, :trains

  def initialize(name)
   @name = name
   @trains = []
  end

#вводим в пустой массив приезжающий поезд
  def add_train(train)
  @trains << train
  end

#удаляем из массива поезд который уехал
  def delete_train(train)
  @trains.delete(train)
  end

#делим на грузовые и пассажирские

  def train_type(type)
    @trains.select {|train| train.type == type}.count
  end
end





