=begin

Dijkstra shortest path finding algorithm

This implementation is using simple directional Graph class,
which vertex & edge is store in hash.

=end

class Dijkstra

  MAX_VALUE = 1_000_000_000

  attr_reader :graph
  def initialize(graph)
    @graph = graph
  end

  def find_shortest_path(source_vertex, target_vertex)

    result = []
    cal_map = {}
    visited = {}
    previous_node = nil
    current_node = source_vertex
    while !calc_map.key?(target_vertex) && !visited.key?(current_node)
      cal_map[current_node] = [nil, {}]
      running_smallest = []
      smallest = MAX_VALUE

      #copy previous value
      unless previous_node.nil?
        cal_map[previous_node][1].each do |k, v|
          unless visited.key?(k)
            cal_map[current_node][1][k] = v
          end
        end
      end

      graph.vertices[current_node].each do |k, v|
        starting_cost = cal_map[current_node][1][current_node][0] || 0
        cost = starting_cost + v

        if cost < smallest
          smallest = cost
          running_smallest[0] = k
          running_smallest[1] = smallest
        end

        unless cal_map[current_node][1].key?(k)
          cal_map[current_node][1][k] = [cost, current_node]
        end
      end

      if current_node != source_vertex
        cal_map[current_node][0] = running_smallest[0]
      end
      visited[current_node] = true

      previous_node = current_node
      if cal_map[current_node][0] != previous_node
        current_node = cal_map[current_node][0]
      else

      end

    end





    return result
  end
end

class Graph
  attr_reader :vertices
  def initialize
    @vertices = {}
  end

  def add_vertex(value)
    unless vertices.key?(value)
      vertices[value] = {}
    end
  end

  def add_edge(source_vertex, target_vertex, cost)
    add_vertex(source_vertex)
    add_vertex(target_vertex)

    vertices[source_vertex][target_vertex] = cost 
  end
end