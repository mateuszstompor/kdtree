require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class ConstructorTests < Minitest::Test

    # The Smallest partitioning tree is the binary tree
    def test_default_constructor
        tree = KdTree::Tree.new
        assert tree.dimension == 2
    end

    def test_n_dimensional_constructor
        tree = KdTree::Tree.new 4
        assert tree.dimension == 4
    end

end
