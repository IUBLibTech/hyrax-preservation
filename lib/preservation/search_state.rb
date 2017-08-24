module Preservation
  class SearchState < Hyrax::SearchState
    def url_for_document(doc, options = {})
      [controller.preservation, doc]
    end
  end
end
