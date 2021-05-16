require_relative 'undirect_graph'

RSpec.describe UndirectGraph do
  let(:graph) { UndirectGraph.new }

  it 'can be instantiate & starting vertices size 0' do
    graph = UndirectGraph.new
    current_vertices = graph.get_vertices
    expect(graph.nil?).to eq false
    expect(current_vertices.nil?).to eq false
    expect(current_vertices.size).to eq 0
  end

  describe '#add_vertex' do
    context 'input is NOT integer' do
      it 'raise ArgumentError' do
        wrong_inputs = [nil, '1', true, [], {}, 1.25]
        wrong_inputs.each do |i|
          expect{graph.add_vertex(i)}.to raise_error(ArgumentError)
        end
      end
    end

    context 'vertex NOT exist' do
      it 'add new element in vertices' do
        graph.add_vertex(1)
        graph.add_vertex(2)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 2
      end
    end

    context 'same vertex exist' do
      it 'NOT add new element in vertices' do
        graph.add_vertex(1)
        graph.add_vertex(1)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 1
      end
    end
  end

  describe '#add_edge' do
    context 'input is NOT integer' do
      it 'raise ArgumentError' do
        wrong_inputs = [[nil, '1'], [true, false], [[], {}], [1.25, 1]]
        wrong_inputs.each do |i|
          expect{graph.add_edge(i[0], i[1])}.to raise_error(ArgumentError)
        end
      end
    end

    context 'source vertex NOT exist' do
      before do
        graph.add_vertex(2)
      end
      it 'add new element in vertices & add destination vertex in edge' do
        graph.add_edge(1, 2)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 2
        expect(current_vertices[1]).to eq [2]
      end
    end

    context 'destination vertex NOT exist' do
      before do
        graph.add_vertex(1)
      end
      it 'add new element in vertices & add source vertex in edge' do
        graph.add_edge(1, 2)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 2
        expect(current_vertices[2]).to eq [1]
      end
    end

    context 'both source and destination vertex are exist' do
      before do
        graph.add_vertex(1)
        graph.add_vertex(2)
        graph.add_vertex(3)
      end
      it 'add edge to both source & destination' do
        graph.add_edge(2, 1)
        graph.add_edge(3, 2)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 3
        expect(current_vertices[1]).to eq [2]
        expect(current_vertices[2]).to eq [1, 3]
        expect(current_vertices[3]).to eq [2]
      end
    end
  end

  describe '#remove_vertex' do
    context 'input is NOT integer' do
      it 'raise ArgumentError' do
        wrong_inputs = [nil, '1', true, [], {}, 1.25]
        wrong_inputs.each do |i|
          expect{graph.remove_vertex(i)}.to raise_error(ArgumentError)
        end
      end
    end

    context 'vertex NOT exists' do
      before do
        graph.add_vertex(1)
        graph.add_vertex(2)
      end
      it 'remove nothing from vertices' do
        graph.remove_vertex(3)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 2
      end
    end

    context 'vertex exists' do
      before do
        graph.add_edge(1,2)
        graph.add_edge(2,3)
        graph.add_edge(1,3)
        graph.add_vertex(4)
      end
      it 'remove vertex from vertices' do
        graph.remove_vertex(1)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 3
        expect(current_vertices[1].nil?).to eq true
      end
      it 'remove all edge in other vertex which is related to it' do
        graph.remove_vertex(1)

        current_vertices = graph.get_vertices
        expect(current_vertices[2]).to eq [3]
        expect(current_vertices[3]).to eq [2]
        expect(current_vertices[4]).to eq []
      end
    end
  end

  describe '#remove_edge' do
    context 'input is NOT integer' do
      it 'raise ArgumentError' do
        wrong_inputs = [[nil, '1'], [true, false], [[], {}], [1.25, 1]]
        wrong_inputs.each do |i|
          expect{graph.remove_edge(i[0], i[1])}.to raise_error(ArgumentError)
        end
      end
    end

    context 'edge NOT exist between vertices' do
      before do
        graph.add_edge(1, 2)
      end
      it 'remove nothing' do
        graph.remove_edge(2, 3)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 2
        expect(current_vertices[1]).to eq [2]
        expect(current_vertices[2]).to eq [1]
      end
    end

    context 'edge exists between vertices' do
      before do
        graph.add_edge(1, 2)
        graph.add_edge(1, 3)
      end
      it 'remove edge for both vertices' do
        graph.remove_edge(1, 3)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 3
        expect(current_vertices[1]).to eq [2]
        expect(current_vertices[3]).to eq []
      end
      it 'can remove edge for both vertices with opposite order' do
        graph.remove_edge(3, 1)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 3
        expect(current_vertices[1]).to eq [2]
        expect(current_vertices[3]).to eq []
      end
    end
  end

  describe '#vertex_exist?' do
    context 'input is NOT integer' do
      it 'raise ArgumentError' do
        wrong_inputs = [nil, '1', true, [], {}, 1.25]
        wrong_inputs.each do |i|
          expect{graph.vertex_exist?(i)}.to raise_error(ArgumentError)
        end
      end
    end

    context 'vertex exist' do
      before do
        graph.add_vertex(1)
      end
      it 'return true' do
        expect(graph.vertex_exist?(1)).to eq true
      end
    end

    context 'vertex NOT exist' do
      before do
        graph.add_vertex(1)
      end
      it 'return false' do
        expect(graph.vertex_exist?(2)).to eq false
      end
    end
  end

  describe '#find_connected_vertices_to' do
    context 'input is NOT integer' do
      it 'raise ArgumentError' do
        wrong_inputs = [nil, '1', true, [], {}, 1.25]
        wrong_inputs.each do |i|
          expect{graph.find_connected_vertices_to(i)}.to raise_error(ArgumentError)
        end
      end
    end

    context 'vertex NOT exist' do
      before do
        graph.add_edge(1, 2)
      end
      it 'return nil' do
        result = graph.find_connected_vertices_to 3

        expect(result).to eq nil
      end
    end

    context 'vertex exist' do
      before do
        graph.add_edge(1, 2)
        graph.add_edge(1, 3)
        graph.add_edge(2, 3)
        graph.add_edge(3, 4)
        graph.add_edge(4, 5)
        graph.add_edge(6, 7)
        graph.add_vertex(8)
      end
      it 'return array of be able to connected vertices' do
        result1 = graph.find_connected_vertices_to 5
        expect(result1).to match_array [1, 2, 3, 4]

        result2 = graph.find_connected_vertices_to 7
        expect(result2).to match_array [6]
      end
      it 'return empty array when there are no connected vertices' do
        result = graph.find_connected_vertices_to 8
        expect(result).to eq []
      end
    end
  end

  describe '#find_any_path_between_vertices' do
    context 'input is NOT integer' do
      it 'raise ArgumentError' do
        wrong_inputs = [[nil, '1'], [true, false], [[], {}], [1.25, 1]]
        wrong_inputs.each do |i|
          expect{graph.find_any_path_between_vertices(i[0], i[1])}.to raise_error(ArgumentError)
        end
      end
    end

    context 'vertices NOT exist' do
      before do
        graph.add_edge(1, 2)
      end
      it 'return nil when source vertex not exist' do
        result = graph.find_any_path_between_vertices(3, 2)

        expect(result).to eq nil
      end
      it 'return nil when destination vertex not exist' do
        result = graph.find_any_path_between_vertices(1, 4)

        expect(result).to eq nil
      end
    end

    context 'vertices exist' do
      before do
        graph.add_edge(1, 2)
        graph.add_edge(1, 3)
        graph.add_edge(1, 4)
        graph.add_edge(2, 3)
        graph.add_edge(2, 4)
        graph.add_edge(3, 4)
        graph.add_edge(4, 5)
        graph.add_edge(6, 7)
        graph.add_vertex(8)
      end
      it 'return array of ordered vertices paths' do
        result = graph.find_any_path_between_vertices(1, 4)

        expected_result = [
          [1, 2, 3, 4],
          [1, 2, 4],
          [1, 3, 2, 4],
          [1, 3, 4],
          [1, 4]
        ]
        expect(result).to match_array expected_result 
      end
      it 'return empty array when there is no path' do
        result = graph.find_any_path_between_vertices(1, 7)

        expect(result).to eq []
      end
    end
  end

end
