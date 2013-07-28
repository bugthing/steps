require_relative '../spec_helper'
require_relative '../../app/models/tool'
describe Tool do
  context "new default" do
    subject { described_class.new }
  end
end
