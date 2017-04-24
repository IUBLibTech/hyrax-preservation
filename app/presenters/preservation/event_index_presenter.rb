module Preservation
  class EventIndexPresenter < Blacklight::IndexPresenter
    # Returns the value of PremisEventType#label for the PremisEventType instance
    # whose #abbr value matches that which is in the solr document.
    def search_result_title
      premis_event_type = PremisEventType.all.find { |premis_event_type| premis_event_type.abbr == document.first(:premis_event_type_ssim) }
      premis_event_type.label
    end
  end
end
