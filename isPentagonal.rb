class Integer
  def isPentagonal?
    if self < 1
      false
    else
      if (1.0/6)*(1 + Math.sqrt(24*self + 1)) % 1 == 0
        true
      else
        false
      end
    end
  end
end
