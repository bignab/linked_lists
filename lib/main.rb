# frozen_string_literal: true

# Represents a full linked list data structure, and includes all the nodes in the linked list.
class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)
    @head = new_node if @head.nil?
    @tail = new_node
    @head.next_node(new_node) unless @head == new_node
  end

  def prepend(value)
    new_node = Node.new(value)
    former_head = @head
    @head = new_node
    @head.next_node(former_head) unless former_head.nil?
  end

  def size
    @head.size
  end

  def at(index)
    @head.traverse_nodes(index).value
  end

  def pop
    list_index = size - 2 # Set index to the second last node in the list
    @head.traverse_nodes(list_index).linked_node = nil
  end

  def contains?(value)
    current_node = @head
    until current_node.nil?
      return true if current_node.value == value

      current_node = current_node.linked_node
    end
    false
  end

  def find(value)
    current_node = @head
    index = 0
    until current_node.nil?
      return index if current_node.value == value

      current_node = current_node.linked_node
      index += 1
    end
    nil
  end

  def to_s
    current_node = @head
    output_str = ''
    until current_node.nil?
      output_str += "( #{current_node.value} ) -> "
      current_node = current_node.linked_node
    end
    output_str[0, output_str.length - 4]
  end

  def insert_at(value, index)
    new_node = Node.new(value)
    current_node = @head
    node_before = nil
    until index.negative?
      node_before = current_node if index == 1
      current_node = current_node.linked_node unless index.zero?
      index -= 1
    end
    node_before.linked_node = new_node
    new_node.linked_node = current_node
  end

  def remove_at(index)
    current_node = @head
    node_before = nil
    node_after = nil
    until index.negative?
      node_before = current_node if index == 1
      node_after = current_node.linked_node
      current_node = current_node.linked_node unless index.zero?
      index -= 1
    end
    node_before.linked_node = node_after
  end
end

# Represents individual nodes in the larger linked list.
class Node
  attr_reader :value
  attr_accessor :linked_node

  def initialize(value = nil)
    @value = value
    @linked_node = nil
  end

  def next_node(new_node)
    if @linked_node.nil?
      @linked_node = new_node
    else
      @linked_node.next_node(new_node)
    end
  end

  def size(sum = 0)
    return (sum + 1) if @linked_node.nil?

    sum += 1
    @linked_node.size(sum)
  end

  def traverse_nodes(index)
    return self if index.zero?
    # If index > 0 but there is no @linked_node to traverse to then throw out of bounds error.
    raise '#at: index is out of bounds.' if @linked_node.nil?

    @linked_node.traverse_nodes(index - 1)
  end
end

test_list = LinkedList.new
test_list.append(1413)
test_list.append(21_341)
test_list.append(313)
test_list.append(4341)
test_list.append(53)
test_list.insert_at(234, 1)
puts test_list.to_s
test_list.remove_at(3)
puts test_list.to_s
