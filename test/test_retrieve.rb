require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class RetrieveTests < Minitest::Test
  def setup
    @tree = Kd::Tree.new 3
    @tree.insert [1, 2, 3], 'cat'
    @tree.insert [10, 22, -3], 'dog'
    @tree.insert [-3, -2.2, 6], 'cow'
    @tree.insert [3.9, -0.2, 1], 'car'
  end

  def test_signle_element_retrieving
    elements = @tree.retrieve [0..2, 0..2, 0..4]
    assert elements.include? 'cat'
    assert elements.length, 1
  end

  def test_retrieving_with_invalid_range
    elements = @tree.retrieve [0..0, 0..0, 0..0]
    assert elements.length, 0
  end

  def test_negative_x_retrieving
    elements = @tree.retrieve [-100...0, -100..100, -100..100]
    assert elements.include? 'cow'
    assert elements.length, 1
  end

  def test_positive_x_retrieving
    elements = @tree.retrieve [0...100, -100..100, -100..100]
    assert elements.include? 'cat'
    assert elements.include? 'dog'
    assert elements.include? 'car'
    assert elements.length, 3
  end
end
