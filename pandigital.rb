class Integer
  def pandigital?
    if self < 0
      return false
    end
    if self.to_s.chars.to_a.include?("0")
      return false
    end
    if self.to_s.length == 9
      selfchars = self.to_s.chars.to_a.sort
      if selfchars == (1..9).to_a.to_s.chars.to_a
        return true
      else
        return false
      end
    else
      return false
    end
  end
  def pandigital0?
    if self < 0
      return false
    end
    if self.to_s.length == 10
      selfchars = self.to_s.chars.to_a.sort
      if selfchars == (0..9).to_a.to_s.chars.to_a
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
