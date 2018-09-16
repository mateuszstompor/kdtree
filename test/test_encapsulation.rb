require 'minitest/autorun'g
require_relative '../lib/kd_tree.rb'

class EncapsulationTests < Minitest::Test

    def test_if_accessing_root_gives_an_error
        tree = Kd::Tree.new
        assert_raises(NoMethodError) do
            tree.root
        end
    end

    def test_if_modification_of_size_gives_an_error
        tree = Kd::Tree.new
        assert_raises(NoMethodError) do
            tree.size = 2
        end
    end

    def test_if_using_internal_function_gives_an_error
        tree = Kd::Tree.new
        assert_raises(NoMethodError) do
            tree.insert_node
        end
    end

end
