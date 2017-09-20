require 'hyrax/preservation/search_state'

module Hyrax
  module Preservation
    class EventsController < ActionController::Base
      include Blacklight::Controller
      include Hydra::Controller::ControllerBehavior
      include Hydra::Catalog
      include Hyrax::Controller

      # Include Blacklight helpers that are needed to avoid breakage when using
      # Blacklight views.
      helper CatalogHelper
      helper ComponentHelper
      helper LayoutHelper

      # Include Hyrax helpers that are needed to avoid breakage when rendering
      # Hyrax views.
      helper HyraxHelper

      # Override Hyrax::UrlHelper#url_for_document
      # helper_method :url_for_document
      helper_method :display_premis_agent
      helper_method :display_premis_event_date_time
      helper_method :display_related_file

      # TODO: We used to include CurationConcerns::ApplicationControllerBehavior
      # here, but that module was merged into Sufia::Controller, which was later
      # converted to Hyrax::Controller. But we're not sure if it's still needed.
      # TODO: Determine whether or not we need to include Hyrax::Controller, and
      # upadate (or delete) these commets accordingly.
      # include Hyrax::Controller
      include Hyrax::ThemedLayoutController
      with_themed_layout '1_column'

      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      protect_from_forgery with: :exception

      # Override rails path for the views by appending 'catalog' as a
      # place to look for views. This allows using default blacklight
      # views if you don't want to override each one.
      def _prefixes
        @_prefixes ||= super + ['catalog']
      end

      configure_blacklight do |config|

        config.search_builder_class = EventsSearchBuilder

        # Index view config
        config.index.document_presenter_class = EventIndexPresenter
        # NOTE: setting `config.index.title_field` here has no effect, because
        # we're currently overriding the presenter class, and the partial that
        # would normally be looking for it. Instead, see the overridden partial
        # in app/views/preservation/events/_index_header_list_default.html.erb
        # and the EventIndexPresenter#search_result_title method.
        config.add_index_field solr_name(:hasEventRelatedObject, :symbol), label: "File", helper_method: :display_related_file
        config.add_index_field solr_name(:premis_event_date_time, :stored_searchable, type: :date), label: "Date", helper_method: :display_premis_event_date_time
        config.add_index_field solr_name(:premis_agent, :symbol), label: "Agent", helper_method: :display_premis_agent

        # Show view config
        config.show.document_presenter_class = EventShowPresenter
        config.add_show_field solr_name(:premis_agent, :symbol), label: "PREMIS Agent"
        config.add_show_field solr_name(:premis_event_date_time, :stored_searchable, type: :date), label: "Date"
        config.add_show_field solr_name(:hasEventRelatedObject, :symbol), label: "File", helper_method: :display_related_file

        # Remove unused actions from the show view. Enabling these breaks the
        # show view because Blacklight generates urls that don't exist. Figuring
        # out how to make them work will take more digging.
        config.show.document_actions.delete(:bookmark)
        config.show.document_actions.delete(:email)
        config.show.document_actions.delete(:sms)
        config.show.document_actions.delete(:citation)

        # Facet config
        # config.add_facet_fields_to_solr_request!
        # config.add_facet_field :premis_event_date_time_ltsi, label: 'Date', range: { segments: false }
        # config.add_facet_field solr_name(:premis_event_type, :symbol), label: 'Type'
      end

      # Overrides CatalogController::UrlHelper#url_for_document. It would be
      # nice to put this method in our own Preservation::UrlHelper module but I
      # couldn't get the helper to load after Hyrax::UrlHelper in
      # order to overwrite the #url_for_document method. NOTE: In any event,
      # this method needs to behave roughly the same way as
      # CurationCocerns::UrlHelper#url_for_document, so if that method changes
      # change this one accordingly.
      # def url_for_document(doc, _options = {})
      #   polymorphic_path([preservation, doc])
      # end

      def search_state
        @search_state ||= Hyrax::Preservation::SearchState.new(params, blacklight_config, self)
      end

      def display_premis_agent(opts={})
        solr_doc = opts[:document]
        premis_agent_mailto_uri = solr_doc[opts[:field]]
        premis_agent_mailto_uri.first.sub(/^mailto\:/, '')
      end

      def display_premis_event_date_time(opts={})
        solr_doc = opts[:document]
        premis_event_date_time = solr_doc[opts[:field]]
        Date.parse(premis_event_date_time.to_s).strftime('%Y-%m-%d')
      end

      def display_related_file(opts={})
        # TODO: Is there a better way than having the controller send back HTML?
        # TODO: Is there a better way to fetch the FileSet ID and Title? This way is confusing.
        solr_doc = opts[:document]
        file_set_id = solr_doc[:hasEventRelatedObject_ssim].first
        file_set_url = Rails.application.routes.url_helpers.hyrax_file_set_path(id: file_set_id)

        # TODO: this is totally klugey. We're pulling back the FileSet object from Fedora in order to get
        # a good name to display it with. Originally, we were getting this value from the Solr document of
        # the PreservationEvent object, but we ran into an issue where the PreservationEventIndexer does
        # not know which FileSet property has been populated with a good, representative name for the FileSet
        # at the time of indexing, because that is determined by configuration within the host app in any one of:
        #  1. the FileSet model
        #  1. the ingest configuration of the FileSet if using hyrax-ingest.
        #  1. the FileSet indexer
        # So either this value needs to be configurable within the host app,
        # or the PreservationEventIndexer (in the hyrax-preservation gem) needs to have similar fallback logic
        # when indexing a representative name for the FileSet.
        file_set = ::FileSet.find(file_set_id)
        file_set_title = file_set&.title&.first ||  file_set&.label || file_set&.filename&.first
        "<a href='#{file_set_url}'>#{file_set_title}</a>".html_safe
      end
    end
  end
end