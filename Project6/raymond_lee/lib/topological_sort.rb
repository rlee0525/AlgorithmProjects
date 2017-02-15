require_relative 'graph'
require 'set'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn's Algorithm
def topological_sort(vertices)
  count_hash = {}
  sorted = []
  queue = []

  vertices.each do |vertex|
    count_hash[vertex] = vertex.in_edges.count
    queue << vertex if vertex.in_edges.empty?
  end

  until queue.empty?
    current = queue.shift
    sorted << current

    current.out_edges.each do |edge|
      vertex = edge.to_vertex
      count_hash[vertex] -= 1

      if count_hash[vertex] == 0
        queue << vertex
      end
    end
  end

  sorted
end

# Tarjan's Algorithm
def topological_sort2(vertices)
  sorted = []
  visited = Set.new

  vertices.each do |vertex|
    dfs(vertex, visited, sorted) unless visited.include?(vertex)
  end

  sorted
end

def dfs(vertex, visited, sorted)
  visited.add(vertex)

  vertex.out_edges.each do |edge|
    dfs(edge.to_vertex, visited, sorted) unless visited.include?(edge.to_vertex)
  end

  sorted.unshift(vertex)
end
