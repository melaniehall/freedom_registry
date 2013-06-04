require './lib/formatter.rb'
require_relative 'spec_helper.rb'

describe Formatter, ".name" do
  subject { Formatter.name(organization, width) }

  context "when organization's name is less than the width" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org"
          org.mailing_city = "City"
          org.mailing_state = "ME"
        end
      }
    let(:width) {10}

    it "left justifies the organization's name in the defined width" do
      expect(subject).to eql("Org       ")
    end
  end

  context "when organization's name longer than the width" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Long_name_Org"
          org.mailing_city = "City"
          org.mailing_state = "ME"
        end
      }
    let(:width) {10}

    it "left justifies the organization's name in the defined width" do
      expect(subject).to eql("Long_na...")
    end
  end
end

describe Formatter, ".id" do
  subject { Formatter.id(id)}
  let!(:id) { 51 }

  it "left justifies the id number within 6 characters" do
    expect(subject).to eql("51    ")
  end
end

describe Formatter, ".location" do
  subject { Formatter.location(organization, width)}
  let!(:organization) {
        Organization.create! do |org|
          org.name = "Org"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
        end
      }
  let!(:width) {15}

  it "separates the mailing_city and mailing_state with a comma and left justifies them both within the width" do
    expect(subject).to eql("Chicago, IL    ")
  end
end

describe Formatter, ".column_header" do
  subject { Formatter.column_header(column_name, width)}
  let!(:column_name) { "Location" }
  let!(:width) { 15 }

  it "left-justies the column name within the width" do
    expect(subject).to eql("Location       ")
  end
end

describe Formatter, ".organizations_for_list_view" do
  subject { Formatter.organization_for_list_view(organization, width)}

    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org1"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
        end
      }

    let!(:formatted_org) {"1      | ... | Chicago, IL              "}
    let!(:width) { 25 }

    it "should output a formatted organization" do
      expect(subject).to eql(formatted_org)
    end
end

describe Formatter, ".organizations_for_profile_view" do
  subject { Formatter.organization_for_profile_view(organization)}

  let!(:organization) {
      Organization.create! do |org|
        org.name = "Org1"
        org.mailing_city = "Chicago"
        org.mailing_state = "IL"
        org.mission_statement = "Mission statement goes here."
        org.contact_name = "Jane Smith"
        org.contact_phone = "555-555-5555"
        org.contact_email = "j@smith.com"
        org.website = "www.jsmith.com"
      end
    }

  let!(:formatted_org) {"\e[0;33mORG1 | Chicago, IL              \nMission: Mission statement goes here.\n"+ Formatter.add_hr(`tput cols`.to_i) +"\nwww.jsmith.comContact:\nJane Smith\n555-555-5555 | j@smith.com\n\n\e[0m"
      }

  it "returns a formatted organization profile" do
    expect(subject).to eql(formatted_org)
  end
end

describe Formatter, ".contact_info" do
  subject { Formatter.contact_info(organization, "name")}

  context "when the organization is not empty" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org1"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
          org.contact_name = "Tracy Higgins"
        end
      }

    let!(:formatted_org) { "\n" + organization.contact_name }

    it "returns a validated name" do
      expect(subject).to eql(formatted_org)
    end
  end
end

describe Formatter, ".contact_info" do
  subject { Formatter.contact_info(organization, "phone")}

  context "when it is NULL" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org1"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
          org.contact_name = "Tracy Higgins"
          org.contact_phone = "NULL"
        end
      }

    let!(:formatted_org) { "" }

    it "returns an empty string" do
      expect(subject).to eql(formatted_org)
    end
  end

  context "when it is not empty" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org1"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
          org.contact_name = "Tracy Higgins"
          org.contact_phone = "555-555-5555"
        end
      }

    let!(:formatted_org) { "\n" + organization.contact_phone }

    it "returns a validated phone number" do
      expect(subject).to eql(formatted_org)
    end
  end
end

describe Formatter, ".contact_email" do
  subject { Formatter.contact_email(organization)}

  context "when it is NULL" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org1"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
          org.contact_name = "Tracy Higgins"
          org.contact_email = "NULL"
        end
      }

    let!(:formatted_org) { "" }

    it "returns an empty string" do
      expect(subject).to eql(formatted_org)
    end
  end

  context "when it is not empty" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org1"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
          org.contact_name = "Tracy Higgins"
          org.contact_email = "e@test.com"
        end
      }

    let!(:formatted_org) { " | " + organization.contact_email }

    it "returns a validated email" do
      expect(subject).to eql(formatted_org)
    end
  end
end

describe Formatter, ".contact_website" do
  subject { Formatter.website(organization)}

  context "when it is NULL" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org1"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
          org.contact_name = "Tracy Higgins"
          org.website = "NULL"
        end
      }

    let!(:formatted_org) { "" }

    it "returns an empty string" do
      expect(subject).to eql(formatted_org)
    end
  end

  context "when it is not empty" do
    let!(:organization) {
        Organization.create! do |org|
          org.name = "Org1"
          org.mailing_city = "Chicago"
          org.mailing_state = "IL"
          org.contact_name = "Tracy Higgins"
          org.website = "www.website.com"
        end
      }

    let!(:formatted_org) { "\n" + organization.website }

    it "returns a validated website" do
      expect(subject).to eql(formatted_org)
    end
  end
end