require 'minitest/autorun'
require_relative '../lib/kd_tree.rb'

class AccessorsTests < Minitest::Test

    def test_dimension_force_change
        tree = Kd::Tree.new
        assert_raises do
            tree.dimension = 4
        end
    end

end
