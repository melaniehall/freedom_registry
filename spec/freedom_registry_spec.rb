require './freedom_registry'
require_relative 'spec_helper.rb'
require './models/organization'

describe FreedomRegistry, ".output_user_selection" do

  context "'find state' is the selection" do
    subject { FreedomRegistry.output_user_selection("find state ME")}
    let(:expected_output) {<<-OUTPUT
145  | Sexual Assault Support Services of Midcoast Maine  | LOCATION: Brunswick, ME

826  | Sexual Assault Support Services of Midcoast Maine  | LOCATION: Brunswick, ME

OUTPUT
}

    it "should print the organizations that match the selected state" do
      subject.should eql expected_output
    end
  end

  context "'find name' is the selection" do
    subject { FreedomRegistry.output_user_selection("find name Abolition")}
    let(:expected_output) {<<-OUTPUT
128  |              Abolition International               | LOCATION: Nashville, TN

954  |              Abolition International               | LOCATION: Nashville, TN

OUTPUT
}

    it "should print the organizations that match the selected name" do
      subject.should eql expected_output
    end
  end

  context "to view an organization's profile" do
    subject { FreedomRegistry.output_user_selection("view 128")}
    let(:expected_output) {<<-OUTPUT


ABOLITION INTERNATIONAL | Nashville, TN
Mission: Combating domestic and international sex trafficking through accreditation, advocacy, education, and restoration
OUTPUT
}

    it "should print the organizations that match the selected name" do
      subject.should eql expected_output
    end
  end

  context "'find keyword' is the selection" do
    subject { FreedomRegistry.output_user_selection("find keyword prevention")}
    let(:expected_output) {"Search by Keyword feature is coming soon"}

    it "should print the feature coming soon message" do
      subject.should eql expected_output
    end
  end

end

describe FreedomRegistry, ".find_current_position(selection)" do

  context "position matches 'find state'" do
    subject { FreedomRegistry.find_current_position("find state TN") }
    let(:expected_position) {"find state TN"}

    it "should be the find state position" do
      subject.should eql expected_position
    end
  end

  context "position matches 'find state'" do
    subject { FreedomRegistry.find_current_position("find state TN") }
    let(:expected_position) {"find state TN"}

    it "should be the find state position" do
      subject.should eql expected_position
    end
  end

  context "position matches 'find keyword'" do
    subject { FreedomRegistry.find_current_position("find keyword prevention") }
    let(:expected_position) {"find keyword prevention"}

    it "should be the find keyword position" do
      subject.should eql expected_position
    end
  end

  context "position matches 'find name'" do
    subject { FreedomRegistry.find_current_position("find name Abolition International") }
    let(:expected_position) {"find name Abolition International"}

    it "should be the find name position" do
      subject.should eql expected_position
    end
  end

  context "position matches 'view id'" do
    subject { FreedomRegistry.find_current_position("view 45") }
    let(:expected_position) {"view 45"}

    it "should be the view id position" do
      subject.should eql expected_position
    end
  end
end



