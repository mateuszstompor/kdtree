require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class ClearTests < Minitest::Test

    def test_clear_on_empty_tree
        tree = Kd::Tree.new
        assert_nil tree.clear
        assert tree.empty?
    end

    def test_clear_on_non_empty_tree
        tree = Kd::Tree.new
        tree.insert [2,3], :test
        assert_nil tree.clear
        assert tree.empty?
    end

end
