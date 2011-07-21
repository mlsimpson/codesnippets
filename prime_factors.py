def prime_factors(num, start=2):
  """Return all prime factors (ordered) of num in a list"""
  candidates = xrange(start, int(sqrt(num)) + 1)
  factor = next((x for x in candidates if (num % x == 0)), None)
  return ([factor] + prime_factors(num / factor, factor) if factor else [num])
