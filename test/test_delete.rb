require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class DeleteTests < Minitest::Test
  attr_accessor :tree, :tree2

  def setup
    @tree = Kd::Tree.new 2
    tree.insert [2, 3], 'mom'

    @tree2 = Kd::Tree.new
    tree2.insert [30, 40], 'a'
    tree2.insert [5, 25], 'b'
    tree2.insert [10, 12], 'c'
    tree2.insert [70, 70], 'd'
    tree2.insert [50, 80], 'e'
    tree2.insert [55, 45], 'f'

    @many_nodes_tree = Kd::Tree.new
    @many_nodes_tree.insert [30, 40], 'a'
    @many_nodes_tree.insert [5, 25], 'b'
    @many_nodes_tree.insert [10, 12], 'c'
    @many_nodes_tree.insert [70, 70], 'd'
    @many_nodes_tree.insert [50, 30], 'e'
    @many_nodes_tree.insert [35, 45], 'f'
  end

  def test_delete_en_empty_tree
    assert_nil @tree.delete('value')
  end

  def test_delete_on_tree_containing_single_value
    assert_equal @tree.delete('mom'), [[2, 3], 'mom']
  end

  def test_value_returing_on_deletion_of_node_with_no_children
    @tree.insert([3, 3], 'dad')
    assert_equal([[3, 3], 'dad'], @tree.delete('dad'))
  end

  def test_size_of_tree_after_deleting_node_with_no_children
    @tree.insert([3, 3], 'dad')
    @tree.delete('dad')
    assert_equal @tree.size, 1
  end

  def test_structure_of_tree_after_deleting_node_with_no_children
    @tree.insert([3, 3], 'dad')
    @tree.delete('dad')
    assert_nil @tree.send(:root).right
  end

  def test_size_of_tree_after_deletion_node_with_both_children
    @many_nodes_tree.delete('d')
    assert_equal(5, @many_nodes_tree.size)
  end

  def test_structure_of_tree_after_deletion_node_with_both_children
    @many_nodes_tree.delete('a')
    assert_equal('f', @many_nodes_tree.send(:root).value)
  end

  def test_structure_of_tree_after_deletion_node_with_one_child
    @many_nodes_tree.delete('d')
    assert_equal('e', @many_nodes_tree.send(:root).right.value)
  end

  def test_sturcture_of_tree_after_deletion_of_node_with_one_leaf_child
    @many_nodes_tree.delete('e')
    assert_equal('f', @many_nodes_tree.send(:root).right.left.value)
    assert_nil(@many_nodes_tree.send(:root).right.right)
    assert_nil(@many_nodes_tree.send(:root).right.left.right)
    assert_nil(@many_nodes_tree.send(:root).right.left.left)
  end

  def test_size_of_tree_after_deleting_node_with_one_left_child
    @many_nodes_tree.delete('e')
    assert_equal(5, @many_nodes_tree.size)
  end

  def test_sturcture_of_tree_after_deletion_of_node_with_one_right_leaf_child
    tree2.delete('e')
    assert_equal('f', tree2.send(:root).right.left.value)
    assert_nil(tree2.send(:root).right.right)
    assert_nil(tree2.send(:root).right.left.right)
    assert_nil(tree2.send(:root).right.left.left)
  end

  def test_size_of_tree_after_deleting_node_with_one_right_child
    tree2.delete('e')
    assert_equal(5, tree2.size)
  end
end
