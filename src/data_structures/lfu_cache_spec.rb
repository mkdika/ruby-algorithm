require_relative 'lfu_cache'

RSpec.describe LfuCache do
  describe '#put' do
    context 'cache size is NOT full' do
      it 'can insert data into cache map' do
        cache = LfuCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)

        expect(cache.cache_map.size).to eq 3
        expect(cache.cache_map_key_to_array).to eq [1,2,3]
        expect(cache.cache_counter[1]).to eq [1,2,3]
      end
    end

    context 'cache size is full' do
      it 'can insert data into cache map & remove the oldest' do
        cache = LfuCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)
        cache.put(4)
        expect(cache.cache_map.size).to eq 3
        expect(cache.cache_map_key_to_array).to eq [2,3,4]
        expect(cache.cache_counter[1]).to eq [2,3,4]
      end
      it 'can insert data and remove the least freq counter data' do
        cache = LfuCache.new(cache_size: 2)
        cache.put(1)
        cache.put(2)

        3.times.each { |i| cache.get(1) }
        2.times.each { |i| cache.get(2) }

        cache.put(3)

        expect(cache.cache_map.size).to eq 2
        expect(cache.cache_map_key_to_array).to eq [1,3]
      end
    end
  end

  describe '#get' do
    context 'data is exist' do
      it 'return value and update cache counter for that value' do
        cache = LfuCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)

        result1 = cache.get(1)
        expect(result1).to eq 1

        result2 = cache.get(2)
        expect(result2).to eq 2

        expect(cache.cache_map.size).to eq 3
        expect(cache.cache_counter[1]).to eq [3]
        expect(cache.cache_counter[2]).to eq [1, 2]
      end
    end

    context 'data is NOT exist' do
      it 'return nil' do
        cache = LfuCache.new(cache_size: 3)
        cache.put(1)
        
        result = cache.get(4)

        expect(result).to eq nil
        expect(cache.cache_map.size).to eq 1
      end
    end
  end
end