def measure(times=1)
  start_time = Time.now
  times.times { yield }
  end_time = Time.now

  (end_time - start_time) / times
end
