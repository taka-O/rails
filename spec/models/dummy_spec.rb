require 'rails_helper'

RSpec.describe Dummy, type: :model do
  subject(:test) { Dummy.new.test }

  it { expect(test).to be_truthy }
end
