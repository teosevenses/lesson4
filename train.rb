class Train
  attr_reader :type, :num
  attr_accessor :route, :station

  def initialize(num)
    @num = num
  end

  def move_forward
    if route != nil && station != nil 
      self.station = station + 1    
    end
  end 

  def move_back
    if route != nil && station != nil 
      self.station = station - 1    
    end
  end 
end
