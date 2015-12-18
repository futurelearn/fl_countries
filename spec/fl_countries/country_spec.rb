require 'spec_helper'

describe FutureLearn::Country do
  describe '.all' do
    let(:countries) { described_class.all }

    it 'returns a an array of countries' do
      expect(countries).to be_a(Array)
      expect(countries.first.code).to eq('GB')
      expect(countries.first.name).to eq('United Kingdom')
    end
  end

  describe 'find_by_code' do
    it 'finds a country by its code' do
      expect(described_class.find_by_code('GB').name).to eq('United Kingdom')
    end

    it 'returns nil if the country is not found' do
      expect(described_class.find_by_code('OMG')).to eq(nil)
    end
  end

  describe 'find_by_code' do
    it 'finds a country by its code' do
      expect(described_class.find_by_name('United Kingdom').code).to eq('GB')
    end

    it 'returns nil if the country is not found' do
      expect(described_class.find_by_name('OMG')).to eq(nil)
    end
  end

  describe 'differences from ISO-3166' do
    it 'contains Kosovo even though it is not in the ISO 3166 country list' do
      expect(described_class.find_by_code('XK').name).to eq('Kosovo')
    end
  end

  describe 'country region' do
    it 'finds UK postal region for United Kingdom' do
      expect(described_class.find_by_name('United Kingdom').postal_region).to eq('uk')
    end

    it 'finds European postal region for European countries' do
      expect(described_class.find_by_name('France').postal_region).to eq('europe')
      expect(described_class.find_by_name('Belgium').postal_region).to eq('europe')
    end

    it 'finds rest of the world postal region for non-European countries' do
      expect(described_class.find_by_name('Japan').postal_region).to eq('world')
      expect(described_class.find_by_name('Australia').postal_region).to eq('world')
    end
  end

  describe 'sorting' do
    let(:a) { described_class.new('DE', 'Germany', 'europe') }
    let(:b) { described_class.new('GB', 'United Kingdom', 'uk') }

    it 'sorts countries alphabetically by name' do
      expect([b, a].sort).to eq([a, b])
    end
  end

  describe 'equality' do
    let(:de1) { described_class.new('DE', 'Germany', 'europe') }
    let(:de2) { de1.dup }
    let(:gb) { described_class.new('GB', 'United Kingdom', 'uk') }

    describe '==' do
      it 'matches if the code is the same' do
        expect(de1).to eq(de2)
        expect(de1).not_to eq(gb)
      end
    end

    describe '#eql?' do
      it 'matches if the code is the same' do
        expect(de1.eql?(de2)).to be true
        expect(de1.eql?(gb)).to be false
      end
    end

    describe 'hash_equality' do
      it 'treats the code as the hash for the key' do
        hash = {}
        hash[de1] = "de1"
        expect(hash).to eq(de1 => "de1")
        hash[de2] = "de2"
        expect(hash).to eq(de2 => "de2")
        hash[gb] = "gb"
        expect(hash).to eq(de2 => "de2", gb => "gb")
      end
    end
  end
end
