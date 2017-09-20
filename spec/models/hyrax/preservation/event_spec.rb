require 'rails_helper'

describe Hyrax::Preservation::Event do
  it 'has a factory' do
    expect(FactoryGirl.create(:event)).to be_a Hyrax::Preservation::Event
  end

  describe '#premis_event_type_label' do
    let(:premis_event_type) { Hyrax::Preservation::PremisEventType.all.sample }
    let(:event) { FactoryGirl.create(:event, premis_event_type: [premis_event_type.uri]) }
    it 'returns the label of the premis event type' do
      expect(event.premis_event_type_label).to eq premis_event_type.label
    end
  end
end
