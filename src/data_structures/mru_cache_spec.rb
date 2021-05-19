require_relative 'mru_cache'

RSpec.describe MruCache do

  describe '#put' do
    context 'cache size is NOT full' do
      it 'can insert data into cache map' do
        cache = MruCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)

        expect(cache.cache_size).to eq 3
        expect(cache.cache_map[1].nil?).to eq false
        expect(cache.cache_map[2].nil?).to eq false
        expect(cache.cache_map[3].nil?).to eq false
        expect(cache.cache_map_key_to_array).to match_array [1, 2, 3]
        expect(cache.page_fault).to eq 3
      end
    end

    context 'cache size is full' do
      it 'replace the most recent put and insert data into cache map' do
        cache = MruCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)
        cache.put(4)
        cache.put(5)

        expect(cache.cache_size).to eq 3
        expect(cache.cache_map[1].nil?).to eq false
        expect(cache.cache_map[2].nil?).to eq false
        expect(cache.cache_map[3].nil?).to eq true
        expect(cache.cache_map[4].nil?).to eq true
        expect(cache.cache_map[5].nil?).to eq false
        expect(cache.cache_map_key_to_array).to match_array [1, 2, 5]
        expect(cache.page_fault).to eq 5
      end
    end
  end

  describe '#get' do
    context 'value found in cache' do
      it 'return value and adjust cache element' do
        cache = MruCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)
        cache.put(4)

        result = cache.get(2)
        expect(result).to eq 2
        expect(cache.cache_size).to eq 3
        expect(cache.cache_map_key_to_array).to match_array [1, 2, 4]
        expect(cache.page_fault).to eq 2

        result = cache.get(4)
        expect(cache.page_fault).to eq 4

        cache.put(5)
        expect(cache.cache_size).to eq 3
        expect(cache.cache_map_key_to_array).to match_array [1, 2, 5]
        expect(cache.page_fault).to eq 5
      end
      it 'when single element return value' do
        cache = MruCache.new(cache_size: 3)
        cache.put(1)

        result = cache.get(1)
        expect(result).to eq 1
        expect(cache.cache_size).to eq 1
        expect(cache.cache_map_key_to_array).to match_array [1]
        expect(cache.page_fault).to eq 1
      end
    end
    context 'value NOT found in cache' do
      it 'return nil and NOT adjust cache element' do
        cache = MruCache.new(cache_size: 3)
        cache.put(1)
        cache.put(2)
        cache.put(3)

        result = cache.get(4)
        expect(result).to eq nil
        expect(cache.cache_size).to eq 3
        expect(cache.cache_map_key_to_array).to match_array [1, 2, 3]
        expect(cache.page_fault).to eq 3
      end
    end
  end
end