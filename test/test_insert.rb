require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class InsertTests < Minitest::Test

    def setup
        @tree = Kd::Tree.new
        @value = "some_value"
    end

    def test_insert_point_with_incorrect_dimension
        assert_raises(Kd::DimensionError) do
            @tree.insert [2, 3, 3], "some_value"
        end
    end

    def test_insert_something_different_than_array_as_coordianate
        assert_raises(ArgumentError) do
            @tree.insert "Hey", @value
        end
    end

    def test_insert
        assert_equal @value, @tree.insert([2, 3.4], @value)
    end

    def test_if_creation_of_tree_with_incorrect_dimension_gives_an_error
        # positive number
        assert_raises(Kd::DimensionError) do
            Kd::Tree.new 1
        end

        # neutral number
        assert_raises(Kd::DimensionError) do
            Kd::Tree.new 0
        end

        # negative number
        assert_raises(Kd::DimensionError) do
            Kd::Tree.new -1
        end
    end

    def test_structure_after_inserting_to_an_empty_tree
        @tree.insert [2, 3.4], @value
        root = @tree.send(:root)
        refute_nil root
        assert_nil root.parent
        assert_nil root.left
        assert_nil root.right
        assert_equal root.value, @value
        assert_equal root.coordinates, [2, 3.4]
    end

end
