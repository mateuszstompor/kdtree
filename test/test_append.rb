require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class EmptinessTests < Minitest::Test

  def test_if_append_operator_adds_value
    tree = Kd::Tree.new
    tree << [1, 2, 'dad']
    assert tree.include? 'dad'
  end

end
