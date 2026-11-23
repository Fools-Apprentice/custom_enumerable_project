module Enumerable
  def my_each_with_index
    if !block_given?
      return self.to_enum(:my_each_with_index)
    end

    index = 0
    my_each do |element|
      yield element, index
      index += 1
    end
    self
  end

  def my_select
    if !block_given?
      return self.to_enum(:my_select)
    end

    selected = []

    my_each do |value|
      selected << value if yield(value)
    end
    return selected
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    if !block_given?
      return self.to_enum(:my_each)
    end

    index = 0
    while index < length
      yield self[index]
      index += 1
    end
    return self
  end
end
