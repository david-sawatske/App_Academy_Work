class Timer
  attr_accessor :seconds

  def initialize(seconds=0)
    @seconds = seconds
  end

  def padded(number)
    number < 10 ? "0#{number}" : "#{number}"
  end

  def time_string
    [padded(@seconds / 3600), padded(@seconds % 3600 / 60), padded(seconds % 60)].join(':')
  end
end
