#
# Author: Mateusz Stompór
#

module Kd
    class DimensionError < StandardError; end

    class Tree
        attr_reader :dimension

        class Node
            attr_reader :coordinates, :value
            attr_accessor :parent, :left, :right

            def initialize coordinates, value, parent
                @coordinates = coordinates
                @value = value
                @parent = parent
                @left = nil
                @right = nil
            end
        end

        def initialize dimension = 2
            raise DimensionError if dimension < 2
            @dimension = dimension
            @root = nil
        end

        # Greater or equal value is on the right side
        def insert coordinates, value
            raise ArgumentError unless coordinates.is_a? Array
            raise DimensionError if coordinates.length != dimension

            if @root
            else
                @root = Node.new coordinates, value, nil
            end

            value
        end

        def root
            @root
        end

        private_constant :Node
        private :root
    end
end
