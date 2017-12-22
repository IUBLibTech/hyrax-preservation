require 'rails_helper'

describe 'Preservation Events details page' do
    let(:preservation_event) do
      create(:event,
        premis_agent: [::RDF::URI.new("mailto:premis_agent@example.org")],
        premis_event_date_time: [DateTime.new(2014,1,16)],
        premis_event_outcome: ["173126004d5f1b13e41a9f3f53ca3d81"])
    end
    before { visit "preservation/events/#{preservation_event.id}" }

    it 'displays the PREMIS event type' do
      premis_event_type = Hyrax::Preservation::PremisEventType.all.find { |premis_event_type| premis_event_type.uri == preservation_event.premis_event_type.first.to_uri.to_s }
      expect(page).to have_text(premis_event_type.label)
    end

    it 'displays the PREMIS agent' do
      expect(page).to have_text('premis_agent@example.org')
    end

    it 'displays the date' do
      expect(page).to have_text('2014-01-16')
    end

    it 'displays the related file' do
      expect(page).to have_link('Example File')
    end

    it 'displays the outcome' do
      expect(page).to have_text('173126004d5f1b13e41a9f3f53ca3d81')
    end
end
