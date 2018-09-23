#
# Author: Mateusz Stompór
#

module Kd
  class DimensionError < StandardError; end

  class Tree
    attr_reader :dimension, :size

    class Node
      attr_accessor :parent, :left, :right, :depth, :coordinates, :value

      def initialize coordinates, value, parent
        @coordinates  = coordinates
        @value        = value
        @parent       = parent
        @left         = nil
        @right        = nil
        @depth        = 0
      end

      def has_children?
        @left || @right
      end

      def count_children
        if @left && @right
          2
        elsif @left || @right
          1
        else
          0
        end
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

    def retrieve ranges
      retrieve_value ranges, 0, @root, []
    end

    def retrieve_value ranges, index, node, values
      return values if node.nil?
      is_point_within_bounds = true
      ranges.each_index { |i|
        is_point_within_bounds &&= ranges[i].include?(node.coordinates[i])
      }
      if is_point_within_bounds
        values << node.value
      end
      if ranges[index].include?(node.coordinates[index])
        retrieve_value ranges, (index + 1) % dimension, node.left, values
        retrieve_value ranges, (index + 1) % dimension, node.right, values
      elsif ranges[index].max < node.coordinates[index]
        retrieve_value(ranges, ((index + 1) % dimension), node.left, values)
      else
        retrieve_value(ranges, ((index + 1) % dimension), node.right, values)
      end
    end

    def minimum_node current_node, dimension_to_find, current_best
      dimension_of_current_node = get_dimension(current_node)
      if dimension_of_current_node == dimension_to_find
        if current_node.left
          minimum_node(current_node.left, dimension_to_find, current_node)
        else
          if current_best.coordinates[dimension_to_find] < current_node.coordinates[dimension_to_find]
            current_best
          else
            current_node
          end
        end
      else
        if current_best.coordinates[dimension_to_find] > current_node.coordinates[dimension_to_find]
          current_best = current_node
        end
        current_node.left ? minimum_node(current_node.left, dimension_to_find, current_best) : current_node
        current_node.right ? minimum_node(current_node.right, dimension_to_find, current_best) : current_node
      end
    end

    def insert_node current_node, node_to_insert, index
      if current_node.coordinates[index] <= node_to_insert.coordinates[index]
        unless current_node.right
          current_node.right = node_to_insert
          node_to_insert.depth = current_node.depth + 1
          node_to_insert.parent = current_node
        else
          new_index = (index + 1) % dimension
          insert_node current_node.right, node_to_insert, new_index
        end
      else
        unless current_node.left
          current_node.left = node_to_insert
          node_to_insert.depth = current_node.depth + 1
          node_to_insert.parent = current_node
        else
          new_index = (index + 1) % dimension
          insert_node current_node.left, node_to_insert, new_index
        end
      end
    end

    def get_dimension node
      node.depth % dimension
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

    def include? value
      return false unless @root
      look_for_value_from @root, value
    end

    def << rhs
      insert rhs.take(rhs.length - 1), rhs.last
    end

    def look_for_value_from node, value
      if value == node.value
        node
      elsif node.has_children?
        left = look_for_value_from node.left, value if node.left
        right = look_for_value_from node.right, value if node.right
        left ? left : right
      else
        nil
      end
    end

    def delete value
      node = look_for_value_from(@root, value) if @root
      node ? delete_node(node) : nil
    end

    def delete_node(node)
      value_to_return = node.value
      coordinates_to_return = node.coordinates
      if !node.has_children?
        parent = node.parent
        if parent
          if parent.left == node
            parent.left = nil
          else
            parent.right = nil
          end
        else
          @root = nil
        end
        @size -= 1
      else
        if node.right
          min = minimum_node(node.right, get_dimension(node), node.right)
          node.coordinates = min.coordinates
          node.value = min.value
          delete_node(min)
        elsif node.left
          min = minimum_node(node.left, get_dimension(node), node.left)
          node.coordinates = min.coordinates
          node.value = min.value
          delete_node(min)
          temp = node.left
          node.left = node.right
          node.right = temp
        end
      end
      return coordinates_to_return, value_to_return
    end

    private_constant :Node
    private :root, :insert_node, :look_for_value_from, :retrieve_value, :minimum_node, :get_dimension
  end
end
