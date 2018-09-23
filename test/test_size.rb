require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class SizeTests < Minitest::Test
  def setup
    @tree = Kd::Tree.new 2
  end

  def test_size_of_empty_tree
    assert_equal @tree.size, 0
  end

  def test_size_of_tree_with_one_node
    assert_equal 0, @tree.size
    @tree.insert [2, 3], 'some_value'
    assert_equal 1, @tree.size
  end

  def test_size_of_tree_with_many_nodes
    value = 'some_value'
    assert_equal 0, @tree.size
    @tree.insert [2, 3], value
    assert_equal 1, @tree.size
    @tree.insert [2, 3], value
    assert_equal 2, @tree.size
  end
end
