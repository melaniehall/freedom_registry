require './freedom_registry'
require_relative 'spec_helper.rb'
require './models/organization'

# describe FreedomRegistry, ".output_user_selection" do

#   context "'find state' is the selection" do
#     subject { FreedomRegistry.output_user_selection("find state ME")}

#     context "no entries exist for ME" do
#       it "should return a blank list" do
#         subject.should be_nil
#       end
#     end

#     context "entries exist for ME" do
#       let!(:organization) {
#         Organization.create! do |org|
#           org.name = "My Org"
#           org.mailing_city = "City"
#           org.mailing_state = "ME"
#         end
#       }
#       let(:expected_output) {<<-OUTPUT
# 1  | My Org  | LOCATION: City, ME
# OUTPUT
#       }

#       it "should return a formatted version of the organization" do
#         subject.should eql expected_output
#       end
#     end
#   end

#   context "'find name' is the selection" do
#     subject { FreedomRegistry.output_user_selection("find name Abolition")}
#     let(:expected_output) {<<-OUTPUT
# 128  |              Abolition International               | LOCATION: Nashville, TN

# 954  |              Abolition International               | LOCATION: Nashville, TN

# OUTPUT
# }

#     it "should print the organizations that match the selected name" do
#       subject.should eql expected_output
#     end
#   end

#   context "to view an organization's profile" do
#     subject { FreedomRegistry.output_user_selection("view 128")}
#     let(:expected_output) {<<-OUTPUT


# ABOLITION INTERNATIONAL | Nashville, TN
# Mission: Combating domestic and international sex trafficking through accreditation, advocacy, education, and restoration
# OUTPUT
# }

#     it "should print the organizations that match the selected name" do
#       subject.should eql expected_output
#     end
#   end

#   context "'find keyword' is the selection" do
#     subject { FreedomRegistry.output_user_selection("find keyword prevention")}
#     let(:expected_output) {"Search by Keyword feature is coming soon"}

#     it "should print the feature coming soon message" do
#       subject.should eql expected_output
#     end
#   end

# end

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



