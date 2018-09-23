require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class IncludeTests < Minitest::Test
  attr_accessor :tree

  def setup
    @tree = Kd::Tree.new
  end

  def test_if_empty_tree_includes_element
    refute tree.include? :mom
  end

  def test_if_non_empty_tree_includes_element
    tree.insert [1, 2], :dad
    assert tree.include? :dad
  end

  def test_if_tree_with_multiple_elements_has_value
    tree.insert [1, 2], :dad
    tree.insert [1, 2], :mom
    tree.insert [1, 2], :cousin
    tree.insert [1, 2], :sister
    assert tree.include? :sister
    assert tree.include? :cousin
    assert tree.include? :mom
  end
end
