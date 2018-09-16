require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class EmptinessTests < Minitest::Test

    def test_if_created_tree_is_empty
        tree = Kd::Tree.new
        assert tree.empty?
    end

    def test_emptiness_after_insertion
        tree = Kd::Tree.new
        tree.insert [2,3], 'value'
        refute tree.empty?
    end

end
