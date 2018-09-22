require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class ClearTests < Minitest::Test

  def setup
    @tree = Kd::Tree.new 2
  end

  def test_clear_on_empty_tree
    assert_nil @tree.clear
    assert @tree.empty?
  end

  def test_clear_on_non_empty_tree
    @tree.insert [2, 3], :test
    assert_nil @tree.clear
    assert @tree.empty?
  end

end
