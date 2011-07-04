#!/usr/bin/env ruby

require 'test/unit'

class LearningRubyThroughTests < Test::Unit::TestCase

  def test_array1
    a = [1]
    assert_equal(1, a.size)
  end
  # NOTE:  Array.size is the actual size of the array.

  def test_array2
    a = [1, 2, 3]
    assert_equal(3, a.length)
  end

  def test_array_shift1
    a = [1]
    a.shift
    assert_equal(nil, a.shift)
  end
  # NOTE:  Array.shift on an empty array returns nil.

  def test_array_shift2
    a = [1, 2]
    num = a.shift
    assert_equal(1, num)
  end

  def test_array_shift3
    a = [1, 2]
    assert_equal(1, a.shift)
  end
  # NOTE:  Array.shift returns the first element of the array, and changes the array
  # by removing that element.

  def test_array_shift4
    a = [1, 2, 3, 4, 5]
    assert_equal([1, 2], a.shift(2))
  end
  # NOTE:  Array.shift(#) returns an array of the first # of elements in the array,
  # changing the original array by removing that element.

  def test_array_select
    a = [2, 5, 2, 2, 3]
    num = a.select {|n| n == 1}
    assert_equal([], num)
  end
  # NOTE:  Array.select invokes the block passing in successive elements from array, returning
  # an array containing those elements for which the block returns a true value
  #
  # Returns empty array if nothing matches in the original array.
  # Non-destructive.

  def test_array_select2
    a = [2, 5, 2, 2, 3]
    num = a.select {|n| n == 2}
    assert_equal([2, 2, 2], num)
  end
  # NOTE:  Array.select returns a new array that contains elements from the original array
  # that match the criteria set forth in the block.

  def test_collect_transforms_elements_of_an_array
    array = [1, 2, 3]
    new_array = array.collect { |item| item + 10 }
    assert_equal [11, 12, 13], new_array

    # NOTE: 'map' is another name for the 'collect' operation
    another_array = array.map { |item| item + 10 }
    assert_equal [11, 12, 13], another_array
  end

  def test_try_each_instead_of_collect
    array = [1, 2, 3]
    new_array = array.each { |item| item + 10 }
    #assert_equal [11, 12, 13], new_array
    assert_equal [1, 2, 3], new_array
  end
  # NOTE:  This doesn't work, since Array.each does not return an array; it simply executes
  # the block for each array value.  While the array value is passed in to the block as a
  # parameter, like collect/map, the original array is untouched.

  def test_try_each_instead_of_collect_change_array
    array = [1, 2, 3]
    array = array.each { |item| item + 10 }
    #assert_equal [11, 12, 13], array
    assert_equal [1, 2, 3], array
  end
  # NOTE:  Nope, can't self-change the array by using array = array.each

  def test_objects_and_constants
    #    assert_equal "", Object.constants.size
  end

  def test_object_constants2
    #    assert_equal "", Object.constants
  end

  def test_strings_and_constants
    #    assert_equal "", String.constants.size
  end

  def test_string_constants2
    #    assert_equal "", String.constants
  end

  def test_string_methods
    #    assert_equal "", String.methods.sort
  end

  def test_hash
    myHash = Hash.new(0)
    # Dynamic Hash; default for values is 0
    myHash["testkey1"] = "value"
    myHash["testkey2"] = "value2"
    myHash["testkey1"] += " added"
    # assert_equal "", myHash
  end

  def test_adding_values_to_array
    myArray = []
    myArray << "what"
    myArray << "the"
    myArray << "what"
    assert_equal ["what", "the", "what"], myArray
  end

  def test_upcase1
    a = "y"
    assert_equal "Y", a.upcase
  end

  def test_upcase2
    a = "Y"
    assert_equal "Y", a.upcase
  end

  def test_reject
    a = [1, 2, 3]
    b = a.reject {|v| v == 1 or v == 3}
    assert_equal [2], b
  end

  def test_map_reject
    # I want to reject ONLY triplets.
    # In the below example, the last "2" should remain
    a = [2, 2, 2, 1, 2]
    b = a.map{|i|
      num = a.select{|v| v == i}.size
      num == 3 ? "" : i
    }.reject{|v|
      v == "" or v == 1 or v == 5
    }
    assert_equal [2, 2, 2, 2], b
  end

  def test_complex_reject
    a = [2, 2, 2, 1, 2]
    newdice = a.reject { |v|
      if a.count(v) == 3
        x = v
      end
      v == 1 or v == 5 or v == x
    }
    assert_equal [2, 2, 2, 2], newdice
  end

  def test_delete_arbitrary_repetition_from_array
    a = [2, 2, 2, 1, 2]
    # 3.times{a.index(2)? a.delete_at(a.index(2)) : nil }
    # Three times test if there's a 2 in the array
    # Each time, delete that index; do nothing if there isn't.
    #
    # What I want:
    # If there are >3 instances of 2, delete those three.
    a.each{|v|
      a.count(v) >= 3 ? 3.times{a.index(v)? a.delete_at(a.index(v)) : nil } : nil
    }
    assert_equal [1, 2], a
  end
  # NOTE:  Consider using drop_while{|arr| block}
  # Drops elements up to, but not including, the first element for which the block returns nil or false
  # and returns an array containing the remaining elements.

  def test_delete_arbitrary_repetion_from_array2
    a = [2, 2, 2, 2, 2]
    a.each{|n|
      3.times{a.delete_at(a.index(n))} if a.count(n) >= 3
    }
    assert_equal [2, 2], a
  end

  def test_each_with_empty_array
    playerarray = Array.new
    y = 2
    playerarray.each {|p|
      y = 1
    }
    assert_equal 2, y
  end
  # NOTE:  Array.each fails if the array is empty.

  def test_delete_arbitrary_repetion_from_array3
    a = [2, 2, 2, 1, 5]
    a.map{|n|
      3.times{a.delete_at(a.index(n))} if a.count(n) >= 3
    }
    a = a.reject{|n|
      n == 1 || n == 5
    }
    assert_equal [], a
  end

end
