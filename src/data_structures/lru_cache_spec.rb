require_relative 'lru_cache'

RSpec.describe LruCache do
  describe '#put' do
    context 'cache size is NOT full' do
      it 'can insert data into cache map & cache nodes' do
        cache = LruCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)
      
        expect(cache.cache_size).to eq 3
        expect(cache.cache_map[1].nil?).to eq false
        expect(cache.cache_map[2].nil?).to eq false
        expect(cache.cache_map[3].nil?).to eq false
        expect(cache.cache_map_key_to_array).to match_array [1, 2, 3]
        expect(cache.cache_nodes_to_array).to eq [1, 2, 3]
      end
    end

    context 'cache size is full' do
      it 'remove the least and insert new data into cache map & cache nodes' do
        cache = LruCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)
        cache.put(4)
      
        expect(cache.cache_size).to eq 3
        expect(cache.cache_map[1].nil?).to eq true
        expect(cache.cache_map[2].nil?).to eq false
        expect(cache.cache_map[3].nil?).to eq false
        expect(cache.cache_map[4].nil?).to eq false
        expect(cache.cache_map_key_to_array).to match_array [2, 3, 4]
        expect(cache.cache_nodes_to_array).to eq [2, 3, 4]
      end
    end
  end

  describe '#get' do
    context 'value found in cache' do
      it 'return value and adjust cache element' do
        cache = LruCache.new(cache_size: 4)
        cache.put(1)
        cache.put(2)
        cache.put(3)
        cache.put(4)
        cache.put(5)
        expect(cache.cache_nodes_to_array).to eq [2, 3, 4, 5]

        result = cache.get(2)
        expect(result).to eq 2
        expect(cache.cache_size).to eq 4
        expect(cache.cache_map_key_to_array).to match_array [3, 4, 5, 2]
        expect(cache.cache_nodes_to_array).to eq [3, 4, 5, 2]

        result = cache.get(2)
        expect(result).to eq 2
        expect(cache.cache_size).to eq 4
        expect(cache.cache_map_key_to_array).to match_array [3, 4, 5, 2]
        expect(cache.cache_nodes_to_array).to eq [3, 4, 5, 2]

        result = cache.get(4)
        expect(result).to eq 4
        expect(cache.cache_size).to eq 4
        expect(cache.cache_map_key_to_array).to match_array [3, 4, 5, 2]
        expect(cache.cache_nodes_to_array).to eq [3, 5, 2, 4]
      end
      it 'when single element return value' do
        cache = LruCache.new(cache_size: 3)
        cache.put(1)

        result = cache.get(1)
        expect(result).to eq 1
        expect(cache.cache_size).to eq 1
        expect(cache.cache_map_key_to_array).to match_array [1]
        expect(cache.cache_nodes_to_array).to eq [1]
      end
    end

    context 'value NOT found in cache' do
      it 'return nil and NOT adjust cache element' do
        cache = LruCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)

        result = cache.get(4)
        expect(result).to eq nil
        expect(cache.cache_size).to eq 3
        expect(cache.cache_map_key_to_array).to match_array [1, 2, 3]
        expect(cache.cache_nodes_to_array).to eq [1, 2, 3]
      end
    end
  end
end