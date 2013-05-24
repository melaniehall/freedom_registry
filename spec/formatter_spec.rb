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

describe Formatter, ".format_output" do
  subject { Formatter.format_output(output) }

  context "when output is empty" do
    let!(:output) { "" }

    it "returns nil-- less returns nil" do
      expect(subject).to eql(nil)
    end
  end

  context "when output has value" do
    let!(:output) { "Hello there" }

    it "prints the output with LESS command" do
      expect(subject).to eql(IO.popen("less", "w") { |f| f.puts output })
    end
  end
end
