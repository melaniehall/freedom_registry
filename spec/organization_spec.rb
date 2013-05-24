require './models/organization'
require_relative 'spec_helper.rb'

describe Organization, ".by_state" do
  subject { Organization.by_state(state) }
  let(:state) { nil }

  it "returns no entries by default" do
    expect(subject).to be_blank
  end

  context "entries exist" do
    let!(:maine_organization) {
      Organization.create! do |org|
        org.name = "My Org"
        org.mailing_city = "City"
        org.mailing_state = "ME"
      end
    }
    let!(:florida_organization) {
      Organization.create! do |org|
        org.name = "My Org"
        org.mailing_city = "City"
        org.mailing_state = "FL"
      end
    }
    let(:state) { 'ME' }

    it "returns only the organizations for the state" do
      subject.should == [maine_organization]
    end
  end
end

describe Organization, ".by_name" do
  subject { Organization.by_name(name) }
  let(:name) { nil }

  it "returns no entries by default" do
    expect(subject).to be_blank
  end

  context "entries exist" do
    let!(:matching_organization) {
      Organization.create! do |org|
        org.name = "My Org"
        org.mailing_city = "City"
        org.mailing_state = "ME"
      end
    }
    let!(:ignored_organization) {
      Organization.create! do |org|
        org.name = "Name"
        org.mailing_city = "City"
        org.mailing_state = "FL"
      end
    }
    let(:name) { 'My Org' }

    it "returns only the organizations with a similar name" do
      subject.should == [matching_organization]
    end
  end
end

describe Organization, ".by_keyword" do
  subject { Organization.by_keyword(keyword) }
  let(:keyword) { 'prevention' }

  it "returns no entries by default" do
    expect(subject).to be_blank
  end

  context "entries exist" do
    let!(:matching_organization) {
      Organization.create! do |org|
        org.name = "My Org"
        org.mission_statement = "Care and prevention"
      end
    }
    let!(:ignored_organization) {
      Organization.create! do |org|
        org.name = "Name"
        org.mission_statement = "Rescue"
      end
    }

    it "returns only the organizations with a matching keyword" do
      subject.should == [matching_organization]
    end
  end
end


describe Organization, ".format_organization_for_list_view" do
  subject { Organization.format_organization_for_list_view(organization) }
  let!(:organization) {
      Organization.create! do |org|
        org.name = "TN_Org1"
        org.mailing_city = "City"
        org.mailing_state = "TN"
      end
  }

    it "returns properly formatted organizations" do
      subject.should == (<<-OUTPUT
1      |     TN_Org1                                                            | LOCATION: City, TN

-------------------------------------------------------------------------------------------------------------------------------------------

OUTPUT
        )
    end
end

describe Organization, ".format_organizations_for_output" do
  subject { Organization.format_organizations_for_output(organizations) }
  let!(:organizations) {Organization.where(mailing_state: state_to_find)}

  let!(:organization_1) {
      Organization.create! do |org|
        org.name = "TN_Org1"
        org.mailing_city = "City"
        org.mailing_state = "TN"
      end
  }

  let!(:organization_2) {
      Organization.create! do |org|
        org.name = "TN_Org2"
        org.mailing_city = "City"
        org.mailing_state = "TN"
      end
  }

  let!(:organization_3) {
    Organization.create! do |org|
      org.name = "IL_Org1"
      org.mailing_city = "City"
      org.mailing_state = "FL"
    end
  }

  let!(:state_to_find) { "TN" }

    it "returns properly formatted organizations" do
      subject.should == (<<-OUTPUT
1      |     TN_Org1                                                            | LOCATION: City, TN

-------------------------------------------------------------------------------------------------------------------------------------------

2      |     TN_Org2                                                            | LOCATION: City, TN

-------------------------------------------------------------------------------------------------------------------------------------------

OUTPUT
        )
    end
end