require 'rails_helper'

describe Hyrax::Preservation::PremisEventType do
  let(:premis_event_type) { Hyrax::Preservation::PremisEventType.new('cap') }
  let(:premis_event_type_uri_namespace) { 'http://id.loc.gov/vocabulary/preservation/eventType/' }

  describe '#uri' do
    it 'returns an RDF::Vocabulary::Term' do
      expect(premis_event_type.uri).to be_a ::RDF::Vocabulary::Term
    end

    it 'returns a URI under the PREMIS Event Type namespace when converted to a string' do
      expect(premis_event_type.uri.to_s).to match /#{premis_event_type_uri_namespace}/
    end
  end

  describe '.all' do
    it 'returns an array of PremisEventType instances' do
      Hyrax::Preservation::PremisEventType.all.each do |premis_event_type|
        expect(premis_event_type).to be_a Hyrax::Preservation::PremisEventType
      end
    end
  end

  describe '.find_by_uri' do
    context 'when there is a corresponding instance that matches the URI passed in' do
      let(:lookup_uri) { 'http://id.loc.gov/vocabulary/preservation/eventType/mes' }
      it 'returns the instance' do
        expect(Hyrax::Preservation::PremisEventType.find_by_uri(lookup_uri).uri.to_s).to eq lookup_uri
      end
    end

    context 'when there is no corresponding record for the URI' do
      let(:lookup_uri) { 'invalid-premis-event-type-uri' }
      it 'raises a Preservation::PremisEventType::NotFound error' do
        expect { Hyrax::Preservation::PremisEventType.find_by_uri(lookup_uri) }.to raise_error Hyrax::Preservation::PremisEventType::NotFound
      end
    end
  end

  describe '.find_by_abbr' do
    context 'when there is a corresponding instance that matches the abbreviation passed in' do
      let(:lookup_abbr) { 'cap' }
      it 'returns the instance' do
        expect(Hyrax::Preservation::PremisEventType.find_by_abbr(lookup_abbr).abbr).to eq lookup_abbr
      end
    end

    context 'when there is no corresponding record for the abbreviation' do
      let(:lookup_abbr) { 'blerg' }
      it 'raises a Preservation::PremisEventType::NotFound error' do
        expect { Hyrax::Preservation::PremisEventType.find_by_abbr(lookup_abbr) }.to raise_error Hyrax::Preservation::PremisEventType::NotFound
      end
    end
  end
end
