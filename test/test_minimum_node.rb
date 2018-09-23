require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class MinimumNodeTests < Minitest::Test
  def setup
    @tree = Kd::Tree.new

    @tree2 = Kd::Tree.new
    @tree2.insert([0, 1], 'dad')
    @tree2.insert([1, 1], 'mom')

    @tree3 = Kd::Tree.new
    @tree3.insert [30, 40], 'a'
    @tree3.insert [5, 25], 'b'
    @tree3.insert [10, 12], 'c'
    @tree3.insert [70, 70], 'd'
    @tree3.insert [50, 30], 'e'
    @tree3.insert [35, 45], 'f'
  end

  def test_minimum_node_of_not_empty_tree
    @tree.insert([0, 1], 'dad')
    root = @tree.send(:root)
    node = @tree.send(:minimum_node, root, 0, root)
    assert_equal 'dad', node.value
  end

  def test_minimum_node_of_empty_subtree_dimension_same_as_depth_of_node
    root = @tree2.send(:root)
    node = @tree2.send(:minimum_node, root.right, 1, root.right)
    assert_equal 'mom', node.value
  end

  def test_minimum_node_of_empty_subtree_dimension_different_from_depth_of_node
    root = @tree2.send(:root)
    node = @tree2.send(:minimum_node, root.right, 0, root.right)
    assert_equal 'mom', node.value
  end

  def test_minimum_node_of_tree_with_many_nodes
    root = @tree3.send(:root)
    node = @tree3.send(:minimum_node, root, 0, root)
    assert_equal('b', node.value)
  end

  def test_minimum_node_of_right_subtree_min_x
    root = @tree3.send(:root)
    node = @tree3.send(:minimum_node, root.right, 0, root.right)
    assert_equal('f', node.value)
  end

  def test_minimum_node_of_right_subtree_min_y
    root = @tree3.send(:root)
    node = @tree3.send(:minimum_node, root.right, 1, root.right)
    assert_equal('e', node.value)
  end
end
