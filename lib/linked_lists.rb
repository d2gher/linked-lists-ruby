# frozen_string_literal: true

require_relative './node'

# Class to repesent a node_list
class LinkedList
  attr_reader(:head, :tail)

  def initialize
    @head = nil
    @tail = nil
  end

  # Add node to the end of the list
  def append(value)
    new_node = Node.new(value)

    if head.nil?
      @head = new_node
      @tail = new_node
      return new_node
    end

    @tail.next_node = new_node
    @tail = new_node
  end

  # Add node to the beginning of the list
  def prepend(value)
    @head = Node.new(value, head)
  end

  # Return the size of the list
  def size
    return 0 if head.nil?

    counter = 1
    current = head
    until current.next_node.nil?
      counter += 1
      current = current.next_node
    end
    counter
  end

  # Return node at a given index
  def at(index)
    current_node = head
    index.times do
      return nil if current_node.next_node.nil?

      current_node = current_node.next_node
    end
    current_node
  end

  # Removes last node in list
  def pop
    return if head.nil?

    current_node = head
    current_node = current_node.next_node until current_node.next_node == tail
    current_node.next_node = nil
    @tail = current_node
  end

  # Checks if value is in list
  def contains?(value)
    current_node = head
    until current_node.nil?
      return true if current_node.value == value

      current_node = current_node.next_node
    end
    false
  end

  # Get index of value in list
  def find(value)
    current_node = head
    counter = 0
    until current_node.nil?
      return counter if current_node.value == value

      counter += 1
      current_node = current_node.next_node
    end
    nil
  end

  # Get string repsentaion of node
  def to_s(node = head, string = '')
    return '( nil ) -> nil' if node.nil?
    return "#{string}( #{node.value} ) -> nil" if node == tail

    string += "( #{node.value} ) -> "
    to_s(node.next_node, string)
  end

  # Insert node at a certain index
  def insert_at(value, index)
    return prepend(value) if index.zero? || index.negative?

    current_node = at(index)
    return append(value) if current_node.nil?

    new_node = Node.new(value, current_node)
    at(index - 1).next_node = new_node
    new_node
  end

  # Remove node at a certain index
  def remove_at(index)
    return nil unless index < size
    return nil if head.nil?

    current_node = at(index)
    @tail = at(index - 1) if current_node.next_node.nil?
    at(index - 1).next_node = current_node.next_node
  end
end
