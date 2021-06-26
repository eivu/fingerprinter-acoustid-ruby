# frozen_string_literal: true

require 'spec_helper'
require 'eivu/misc'

describe Eivu::Misc do
  subject(:traversal) { described_class.traverse }

  describe '.traverse' do
    it 'works', vcr: true do
      traversal
    end
  end
end
 