require './lib/formatter.rb'
require_relative 'spec_helper.rb'

describe Formatter, ".format_name" do
  subject { Formatter.format_name(string) }
  let(:string) { "Organization" }

  it "adds padding and left-justifies string within 70 characters" do
    expect(subject).to eql("    Organization                                                      ")
  end
end

describe Formatter, ".format_id" do
  subject { Formatter.format_id(id_string) }
  let(:id_string) { "35" }

  it "left justifies id_string within 6 characters" do
    expect(subject).to eql(id_string + "    ")
  end
end

describe Formatter, ".add_hr" do
  subject { Formatter.add_hr }

  it "adds a horizontal rule across terminal_width" do
    expect(subject).to eql("\n--------------------------\n\n")
  end
end


