#
# Author: Mateusz Stompór
#

module Kd
    class DimensionError < StandardError; end

    class Tree
        attr_reader :dimension, :size

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
            @size = 0
        end

        # Greater or equal value is on the right side
        def insert coordinates, value
            raise ArgumentError unless coordinates.is_a? Array
            raise DimensionError if coordinates.length != dimension
            @size += 1
            node = Node.new coordinates, value, nil
            if @root
                insert_node @root, node, 0
            else
                @root = node
            end

            value
        end

        def insert_node current_node, node_to_insert, index
            if current_node.coordinates[index] <= node_to_insert.coordinates[index]
                unless current_node.right
                    current_node.right = node_to_insert
                    node_to_insert.parent = current_node
                else
                    new_index = (index + 1) % dimension
                    insert_node current_node.right, node_to_insert, new_index
                end
            else
                unless current_node.left
                    current_node.left = node_to_insert
                    node_to_insert.parent = current_node
                else
                    new_index = (index + 1) % dimension
                    insert_node current_node.left, node_to_insert, new_index
                end
            end
        end

        def clear
            @root = nil
        end

        def root
            @root
        end

        def empty?
            !@root
        end

        private_constant :Node
        private :root, :insert_node
    end
end
