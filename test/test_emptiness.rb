require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class EmptinessTests < Minitest::Test
  def setup
    @tree = Kd::Tree.new 2
  end

  def test_if_created_tree_is_empty
    assert @tree.empty?
  end

  def test_emptiness_after_insertion
    @tree.insert [2, 3], 'value'
    refute @tree.empty?
  end
end
