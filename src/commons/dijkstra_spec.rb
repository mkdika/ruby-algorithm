require_relative 'dijkstra'

RSpec.describe Dijkstra do
  describe '#find_shortest_path' do
    it 'find the shortest path from source_vertex to target_vertex' do
      graph = Graph.new
      graph.add_edge('A', 'B', 5)
      graph.add_edge('A', 'C', 4)
      graph.add_edge('B', 'E', 13)
      graph.add_edge('B', 'F', 6)
      graph.add_edge('C', 'D', 8)
      graph.add_edge('C', 'E', 11)
      graph.add_edge('D', 'E', 3)
      graph.add_edge('E', 'G', 6)
      graph.add_edge('F', 'G', 17)

      dij = Dijkstra.new(graph)
      result = dij.find_shortest_path('A', 'G')

      expected_result_path = ['A', 'C', 'D', 'E', 'G']
      expect(result).to eq expected_result_path
    end
  end
end

RSpec.describe Graph do
  let(:graph) { Graph.new }
  describe '#add_vertex' do
    it 'can add vertex into vertices list' do
      graph.add_vertex("A")

      expect(graph.vertices.size).to eq 1
      expect(graph.vertices.keys).to eq ['A']
      empty_hash = {}
      expect(graph.vertices['A']).to eq empty_hash
    end
  end

  describe '#add_edge' do
    it 'can add edge between vertices' do
      graph.add_edge('A','B',5)
      graph.add_edge('A','C',3)

      empty_hash = {}
      expected_hash = {'B' => 5, 'C' => 3}
      expect(graph.vertices.size).to eq 3
      expect(graph.vertices['A']).to eq expected_hash
      expect(graph.vertices['B']).to eq empty_hash
      expect(graph.vertices['C']).to eq empty_hash
    end
  end
end