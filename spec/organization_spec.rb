require './models/organization'
require_relative 'spec_helper.rb'

describe Organization do
  it 'displays the organization name' do
    expected = "Organization Name"

    expect(Organization.new.to_s).to eql expected
  end
end