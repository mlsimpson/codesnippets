class Integer
  def isLychrel?
    i = 1
    iter = self
    while i < 50
      iter = iter + iter.to_s.reverse.to_i
      if iter.to_s == iter.to_s.reverse
        return false
      end
      i += 1
    end
    return true
  end
end
