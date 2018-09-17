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
            Kd::Tree.new(-1)
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

    # Case 1
    # Empty tree -> insert node -> insert to right of the root
    def test_insert_case_1
        # Setup
        @tree.insert [2, 3.4], @value
        other_value = "other_value"
        @tree.insert [3, 4.4], other_value
        # Actual test
        root = @tree.send(:root)
        assert_nil root.parent
        assert_nil root.left
        right_child = root.right
        refute_nil right_child
        assert_equal right_child.parent, root
        assert_equal right_child.coordinates, [3, 4.4]
        assert_equal right_child.value, other_value
        assert_nil right_child.right
        assert_nil right_child.left
    end

    # Case 2
    # Empty tree -> insert node -> insert to left of the root
    def test_insert_case_2
        # Setup
        @tree.insert [2, 3.4], @value
        other_value = "other_value"
        @tree.insert [1, 4.4], other_value
        # Actual test
        root = @tree.send(:root)
        assert_nil root.parent
        assert_nil root.right
        left_child = root.left
        refute_nil left_child
        assert_equal left_child.parent, root
        assert_equal left_child.coordinates, [1, 4.4]
        assert_equal left_child.value, other_value
        assert_nil left_child.right
        assert_nil left_child.left
    end

    # Case 3
    # Empty tree -> insert node -> insert to left of the root -> insert to left once again
    def test_insert_case_3
        # Setup
        @tree.insert [2, 3.4], @value
        @tree.insert [1, 4.4], @value
        @tree.insert [1, 3.4], @value
        # Actual test
        root = @tree.send(:root)
        assert_nil root.parent
        assert_nil root.right
        left_child = root.left
        refute_nil left_child
        assert_equal left_child.parent, root
        assert_equal left_child.coordinates, [1, 4.4]
        assert_equal left_child.value, @value
        assert_nil left_child.right
        most_left_node = left_child.left
        refute_nil most_left_node
        assert_equal most_left_node.parent, left_child
        assert_nil most_left_node.left
        assert_nil most_left_node.right
        assert_equal most_left_node.coordinates, [1, 3.4]
        assert_equal most_left_node.value, @value
    end

    # Case 4
    # Empty tree -> insert node -> insert to right of the root -> insert to right once again
    def test_insert_case_4
        # Setup
        @tree.insert [2, 3.4], @value
        @tree.insert [3, 4.4], @value
        @tree.insert [3, 5.4], @value
        # Actual test
        root = @tree.send(:root)
        assert_nil root.parent
        assert_nil root.left
        right_child = root.right
        refute_nil right_child
        assert_equal right_child.parent, root
        assert_equal right_child.coordinates, [3, 4.4]
        assert_equal right_child.value, @value
        assert_nil right_child.left
        most_right_node = right_child.right
        refute_nil most_right_node
        assert_equal most_right_node.parent, right_child
        assert_nil most_right_node.left
        assert_nil most_right_node.right
        assert_equal most_right_node.coordinates, [3, 5.4]
        assert_equal most_right_node.value, @value
    end

end
