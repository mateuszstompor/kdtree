require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class EncapsulationTests < Minitest::Test

  def setup
    @tree = Kd::Tree.new
  end

  def test_if_accessing_root_gives_an_error
    assert_raises(NoMethodError) do
      @tree.root
    end
  end

  def test_if_modification_of_size_gives_an_error
    assert_raises(NoMethodError) do
      @tree.size = 2
    end
  end

  def test_if_using_internal_function_gives_an_error
    assert_raises(NoMethodError) do
      @tree.insert_node
    end
  end

  def test_if_using_retrieve_value_gives_an_error
    assert_raises(NoMethodError) do
      @tree.retrieve_value
    end
  end

  def test_if_look_for_value_from_gives_an_error
    assert_raises(NoMethodError) do
      @tree.look_for_value_from
    end
  end

  def test_if_minimum_node_gives_an_error
    assert_raises(NoMethodError) do
      @tree.minimum_node(@tree.send(:root), 0, @tree.send(:root))
    end
  end

  def test_if_get_dimension_gives_an_error
    assert_raises(NoMethodError) do
      @tree.get_dimension(@tree.send(:root))
    end
  end

end
