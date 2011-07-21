class Integer
  def isPrime?
    if self == 1
      return false
    elsif self < 4
      return true
    elsif self % 2 == 0
      return false
    elsif self < 9
      return true
    elsif self % 3 == 0
      return false
    else
      r = Math.sqrt(self).floor
      f = 5
      while f <= r
        if self % f == 0
          return false
        end
        if self % (f + 2) == 0
          return false
        end
        f += 6
      end
      return true
    end
  end
end

