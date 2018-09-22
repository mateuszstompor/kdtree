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
      elsif node.left
        look_for_value_from node.left, value
      elsif node.right
        look_for_value_from node.right, value
      else
        nil
      end
    end

    def delete value
      node = look_for_value_from(@root, value) if @root
      if node
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
          value
        elsif node.count_children == 2
          raise 'Unsupported case'
        else
          raise 'Unsupported case'
        end
      end
    end

    private_constant :Node
    private :root, :insert_node, :look_for_value_from, :retrieve_value
  end
end
