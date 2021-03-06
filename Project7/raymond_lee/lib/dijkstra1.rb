require_relative 'graph'
require 'byebug'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = {
    source => {
      cost: 0,
      previous_edge: nil
    }
  }

  until possible_paths.empty?
    current, current_cost = possible_paths.min_by { |_, v| v[:cost] }
    shortest_paths[current] = current_cost
    possible_paths.delete(current)
    current.out_edges.each do |edge|
      next_vertex = edge.to_vertex
      possible_paths[next_vertex] = {
        cost: edge.cost + current_cost[:cost],
        previous_edge: current
      }
    end
  end

  shortest_paths
end
