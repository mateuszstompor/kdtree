require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class SearchTests < Minitest::Test

  attr_accessor :tree

  def setup
    @tree = Kd::Tree.new
    tree.insert [30, 40], 'a'
    tree.insert [5, 25], 'b'
    tree.insert [10, 12], 'c'
    tree.insert [70, 70], 'd'
    tree.insert [50, 30], 'e'
    tree.insert [35, 45], 'f'
  end

  def test_look_for_value_node_has_one_right_child
    root = tree.send(:root)
    assert_equal 'd', tree.send(:look_for_value_from, root, 'd').value
  end

  def test_look_for_value_node_has_one_left_child
    root = tree.send(:root)
    assert_equal 'e', tree.send(:look_for_value_from, root, 'e').value
  end

end
