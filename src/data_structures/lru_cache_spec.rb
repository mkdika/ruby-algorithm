require_relative 'lru_cache'

RSpec.describe LruCache do
  

  context '#put' do
    it 'can insert data into cache' do
      lru_cache = LruCache.new(cache_size: 5)
      lru_cache.put(1, 'A')
    
      expect(lru_cache.cache_map.empty?).to eq false
    end

    it 'can return existing data from cache' do
      lru_cache = LruCache.new(cache_size: 5)
      lru_cache.put(1, 'X')

      expect(lru_cache.get(1)).to eq 'X'
    end

    it 'store & evict cache key into cache frame' do
      lru_cache = LruCache.new(cache_size: 2)
      lru_cache.put(1, 'A') 
      lru_cache.put(2, 'B') 
      lru_cache.put(3, 'C') 

      expect(lru_cache.cache_map_key_to_array).to eq [2, 3]
      expect(lru_cache.cache_size).to eq 2
      expect(lru_cache.cache_nodes_to_array).to eq [2, 3]
    end
  end

  context '#get' do
    it 'can evict least cache key with most recent one' do
      lru_cache = LruCache.new(cache_size: 2)
      lru_cache.put(1, 'A') 
      lru_cache.put(2, 'B') 
      result = lru_cache.get(1)

      expect(result).to eq 1
      expect(lru_cache.cache_map_key_to_array).to eq [1, 2]
      expect(lru_cache.cache_size).to eq 2
      expect(lru_cache.cache_nodes_to_array).to eq [2, 1]
    end

    it 'return nil when key not found' do
      lru_cache = LruCache.new(cache_size: 2)
      lru_cache.put(1, 'A') 
      lru_cache.put(2, 'B') 
      result = lru_cache.get(4)

      expect(result).to eq nil
      expect(lru_cache.cache_map_key_to_array).to eq [1, 2]
      expect(lru_cache.cache_size).to eq 2
      expect(lru_cache.cache_nodes_to_array).to eq [1, 2]
    end
  end
end