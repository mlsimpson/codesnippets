def power(a, b)
  if b.zero?
    return 1
  end
  if a.zero?
    return 0
  end
  if b.even?
    return power(a*a, b/2)
  else
    return a*power(a*a, b/2)
  end
end
