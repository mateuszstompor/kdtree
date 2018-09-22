require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class ConstructorTests < Minitest::Test

  def setup
    @tree = Kd::Tree.new 2
  end

  # The Smallest partitioning tree is the binary tree
  def test_default_constructor
    assert @tree.dimension == 2
  end

  def test_n_dimensional_constructor
    tree = Kd::Tree.new 4
    assert tree.dimension == 4
  end

  def test_if_empty_tree_has_nil_root
    assert_nil @tree.send(:root)
  end

end
