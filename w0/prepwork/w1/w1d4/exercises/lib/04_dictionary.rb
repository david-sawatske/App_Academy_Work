class Dictionary
  def initialize
    @d = {}
  end

  def entries
    @d
  end

  def add(entry)
    if entry.is_a?(Hash)
      @d.merge!(entry)
    elsif entry.is_a?(String)
      @d[entry] = nil
    end
  end

  def include?(key)
    @d.include?(key)
  end

  def find(key_prefix)
    ret = {}

    @d.each do |key, value|
      ret.merge!(key => value) if key[0..key_prefix.length - 1] == key_prefix
    end

    ret
  end

  def keywords
    @d.each_key.sort
  end

  def printable
    @d.sort.map { |key, value| "[#{key}] \"#{value}\"" }.join("\n")
  end
end
