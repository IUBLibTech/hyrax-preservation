module Hyrax
  module Preservation
    class SearchState < Hyrax::SearchState
      def url_for_document(doc, options = {})
        [controller.hyrax_preservation, doc]
      end
    end
  end
end
