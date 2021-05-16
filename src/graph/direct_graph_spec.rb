require_relative 'direct_graph'

RSpec.describe DirectGraph do
  let(:graph) { DirectGraph.new }

  describe '#add_vertex' do
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

  describe '#add_neighbor' do
    context 'source vertex NOT exist' do
      before do
        graph.add_vertex(2)
      end
      it 'add new element in vertices & its neighbor' do
        graph.add_neighbor(1, 2)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 2
        expect(current_vertices[1]).to eq [2]
        expect(current_vertices[2]).to eq []
      end
    end

    context 'destination vertex NOT exist' do
      before do
        graph.add_vertex(1)
      end
      it 'add new element in vertices & add source vertex in edge' do
        graph.add_neighbor(2, 1)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 2
        expect(current_vertices[2]).to eq [1]
        expect(current_vertices[1]).to eq []
      end
    end

    context 'both source and destination vertex are exist' do
      before do
        graph.add_vertex(1)
        graph.add_vertex(2)
        graph.add_vertex(3)
      end
      it 'add edge to both source & destination' do
        graph.add_neighbor(2, 1)
        graph.add_neighbor(2, 3)

        current_vertices = graph.get_vertices
        expect(current_vertices.size).to eq 3
        expect(current_vertices[1]).to eq []
        expect(current_vertices[2]).to eq [1, 3]
        expect(current_vertices[3]).to eq []
      end
    end
  end


  describe '#has_cyclic?' do
    context 'graph has cyclic connected vertices' do
      it 'return true' do
        graph.add_vertex(1)
        graph.add_vertex(2)
        graph.add_vertex(3)
        graph.add_vertex(4)
        graph.add_neighbor(1, 2)
        graph.add_neighbor(2, 3)
        graph.add_neighbor(3, 4)
        graph.add_neighbor(4, 1)

        result = graph.has_cyclic?

        expect(result).to eq true
      end
    end
    
    context 'graph has NOT cyclic connected vertices' do
      it 'return false' do
        graph.add_vertex(1)
        graph.add_vertex(2)
        graph.add_vertex(3)
        graph.add_vertex(4)
        graph.add_neighbor(1, 2)
        graph.add_neighbor(2, 3)
        graph.add_neighbor(3, 4)

        result = graph.has_cyclic?

        expect(result).to eq false
      end
    end
  end
end


