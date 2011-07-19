def timing_method(block=nil, *args)
  start = Time.now
  if block_given?
    yield
  else
    self.send(block, args)
  end
  finish = Time.now
  print "Elapsed time:  #{(finish - start)*1000} milliseconds\n"
end
