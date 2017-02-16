require_relative 'graph'
require_relative 'priority_map'
require 'byebug'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  shortest_paths = {}
  possible_paths = PriorityMap.new { |a, b| a[:cost] <=> b[:cost] }
  possible_paths[source] = {
    cost: 0,
    previous_edge: nil
  }

  until possible_paths.empty?
    current, current_cost = possible_paths.extract
    shortest_paths[current] = current_cost
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
