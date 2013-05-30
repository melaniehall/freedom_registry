require './freedom_registry'
require_relative 'spec_helper.rb'
require './models/organization'

describe FreedomRegistry, "#find_current_position" do

  context "position matches 'by state'" do
    subject { FreedomRegistry.new.find_current_position(selection) }
    let(:selection) {"by state TN"}
    let(:expected_position) {"by state TN"}

    it "should be the by state position" do
      subject.should eql expected_position
    end
  end

  context "position matches 'by name'" do
    subject { FreedomRegistry.new.find_current_position(selection) }
    let(:selection) {"by name Abolition"}
    let(:expected_position) {"by name Abolition"}

    it "should be the by name position" do
      subject.should eql expected_position
    end
  end

  context "position matches 'by keyword'" do
    subject { FreedomRegistry.new.find_current_position(selection) }
    let(:selection) {"by keyword prevention"}
    let(:expected_position) {"by keyword prevention"}

    it "should be the by keyword position" do
      subject.should eql expected_position
    end
  end

  context "position matches 'list all'" do
    subject { FreedomRegistry.new.find_current_position(selection) }
    let(:selection) {"list all"}
    let(:expected_position) {"list all"}

    it "should be the list all position" do
      subject.should eql expected_position
    end
  end

  context "position matches 'view id'" do
    subject { FreedomRegistry.new.find_current_position(selection) }
    let(:selection) {"view 80"}
    let(:expected_position) {"view 80"}

    it "should be the view id position" do
      subject.should eql expected_position
    end
  end

  context "selection is incorrect" do
    subject { FreedomRegistry.new.find_current_position(selection) }
    let(:selection) {"abc"}
    let(:expected_position) {"wrong_input"}

    it "should be the view id position" do
      subject.should eql expected_position
    end
  end
end



