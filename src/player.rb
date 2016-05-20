class Player
  private_class_method :new

  def opponent
    ObjectSpace.each_object(Player).select{|p| p.class != self.class }.first
  end 
end