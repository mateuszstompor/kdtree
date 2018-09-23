require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class MinimumNodeTests < Minitest::Test

  def setup
    @tree = Kd::Tree.new
  end

  def test_minium_node_of_empty_tree
    assert_nil @tree.send(:minimum_node, @tree.send(:root), 0)
  end

  def test_minimum_node_of_not_empty_tree
    @tree.insert([0, 1], 'dad')
    node = @tree.send(:minimum_node, @tree.send(:root), 0)
    assert_equal 'dad', node.value
  end

  def test_minimum_node_of_empty_subtree
    @tree.insert([0, 1], 'dad')
    @tree.insert([1, 1], 'mom')
    node = @tree.send(:minimum_node, @tree.send(:root).right, 0)
    assert_equal 'mom', node.value
  end

end
