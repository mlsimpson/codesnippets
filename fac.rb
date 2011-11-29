class Integer
  def fac
    (1..self).reduce(:*)
  end
end
