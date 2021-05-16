class DirectGraph
  def initialize
    @vertices = {}
  end

  def get_vertices
    return deep_copy(@vertices)
  end

  def add_vertex(value)
    unless @vertices[value]
      @vertices[value] = []
    end
  end

  def add_neighbor(source_vertex, destination_vertex)
    unless @vertices[source_vertex]
      add_vertex(source_vertex)
    end
    unless @vertices[destination_vertex]
      add_vertex(destination_vertex)
    end
    @vertices[source_vertex] << destination_vertex
  end

  # USE DFS
  def has_cyclic?
    being_visit = {}
    has_visit = {}
    return check_cyclic(@vertices.first[0], being_visit, has_visit) 
  end

  private

  def check_cyclic(vertex, being_visit, has_visit)
    found = false
    being_visit[vertex] = true
    @vertices[vertex].each do |v|
      if being_visit.key?(v)
        found = true
        break
      end
      unless has_visit.key?(v)
        has_visit[v] = true
        return check_cyclic(v, being_visit, has_visit) 
      end
    end
    being_visit[vertex] = false
    has_visit[vertex] = true
    return found
  end

  def deep_copy(object)
    return Marshal.load(Marshal.dump(object))
  end
end