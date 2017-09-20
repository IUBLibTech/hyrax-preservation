require 'rails_helper'

describe Hyrax::Preservation do
  describe '::VERSION' do
    it 'contains the semantic version of the gem' do
      # TODO: allow release candidate syntaxes?
      expect(Hyrax::Preservation::VERSION).to match(/\d+\.\d+\.\d+/)
    end
  end
end
