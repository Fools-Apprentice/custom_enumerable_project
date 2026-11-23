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

  def my_all?
    my_each do |value|
      return false unless yield(value)
    end
    return true
  end

  def my_any?
    is_match = false
    my_each do |value|
      yield(value) ? is_match = true : next
    end
    return is_match
  end

  def my_none?

    my_each do |value|
      if yield(value)
        return false
      end
    end

    return true

  end

  def my_count
    total = 0
    if !block_given?
      my_each do |value|
          total += 1
      end
      return total
    end


    my_each do |value|
      yield(value) ? total += 1 : next
    end
    return total
  end

  def my_map
    if !block_given?
      return self.to_enum(:my_map)
    end
    mapped = []
    my_each do |value|
      mapped << yield(value)      
    end
    return mapped
  end

  def my_inject(initial)
    accumulator = initial
    my_each do |value|
      accumulator = yield accumulator, value
    end
    return accumulator
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
