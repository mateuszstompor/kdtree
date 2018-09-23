require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class AppendTests < Minitest::Test
  def setup
    @tree = Kd::Tree.new
  end

  def test_if_append_operator_adds_value
    @tree << [1, 2, 'dad']
    assert @tree.include? 'dad'
  end

  def test_if_giving_incorrect_data_returns_an_error
    assert_raises(Kd::DimensionError) do
      @tree << [2, 3, 4, 'mom']
    end
  end
end
