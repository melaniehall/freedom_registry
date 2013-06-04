require './app/models/organization'
require_relative 'spec_helper.rb'
require './app/controllers/freedom_registry_controller.rb'
require './freedom_registry'
require './lib/formatter'

describe FreedomRegistryController, ".find_by" do
  subject { FreedomRegistryController.new.find_by(selection) }
  let(:expected_message) { FreedomRegistry::NO_RESULTS }

  context "state: search-term is empty" do
    let!(:matching_organization) {
      Organization.create! do |org|
        org.name = "My Org1"
        org.mailing_city = "City"
        org.mailing_state = "ME"
      end
    }
    let!(:ignored_organization) {
      Organization.create! do |org|
        org.name = "My Org2"
        org.mailing_city = "City"
        org.mailing_state = "FL"
      end
    }
    let!(:selection) { 'by state ' }

    it "returns an empty string" do
       expect(subject).to eql ("")
    end
  end

  context "state: search-term has one entry" do
    let!(:matching_organization) {
      Organization.create! do |org|
        org.name = "My Org1"
        org.mailing_city = "City"
        org.mailing_state = "ME"
      end
    }
    let!(:ignored_organization) {
      Organization.create! do |org|
        org.name = "My Org2"
        org.mailing_city = "City"
        org.mailing_state = "FL"
      end
    }
    let!(:selection) { 'by state ME' }

    it "returns only the organizations for the state" do
      subject.should include(matching_organization.name, matching_organization.mailing_city, matching_organization.mailing_state)

    end
  end

  context "state search-term: has no matching entries" do
    let!(:matching_organization) {
      Organization.create! do |org|
        org.name = "My Org1"
        org.mailing_city = "City"
        org.mailing_state = "ME"
      end
    }
    let!(:ignored_organization) {
      Organization.create! do |org|
        org.name = "My Org2"
        org.mailing_city = "City"
        org.mailing_state = "FL"
      end
    }
    let!(:selection) { 'by state MK' }

    let(:formatted_output) { "" }

    it "returns an empty string" do
       expect(subject).to eql (formatted_output)
    end
  end

  context "name: search-term is empty" do
    let!(:selection) { "by name " }

    it "returns an empty string by default" do
      expect(subject).to eql("")
    end
  end

  context "name: search-term has one matching entry" do
    let!(:matching_organization) {
      Organization.create! do |org|
        org.name = "Org International"
        org.mailing_city = "City"
        org.mailing_state = "ME"
      end
    }
    let!(:ignored_organization) {
      Organization.create! do |org|
        org.name = "Organization Domestic"
        org.mailing_city = "City"
        org.mailing_state = "FL"
      end
    }
    let!(:selection) { "by name International" }

    it "returns only formatted organizations with similar names to selection" do
      subject.should include(matching_organization.name, matching_organization.mailing_city, matching_organization.mailing_state)
    end
  end

  context "keyword: search-term is empty" do
    let!(:selection) { "by keyword " }

    it "returns an empty string by default" do
      expect(subject).to eql("")
    end
  end

  context "keyword: search-term has one matching entry" do
    let!(:matching_organization) {
      Organization.create! do |org|
        org.name = "Org International"
        org.mailing_city = "City"
        org.mailing_state = "ME"
        org.mission_statement = "We love people."
      end
    }
    let!(:ignored_organization) {
      Organization.create! do |org|
        org.name = "Organization Domestic"
        org.mailing_city = "City"
        org.mailing_state = "FL"
        org.mission_statement = "We help people."
      end
    }
    let!(:selection) { "by keyword love" }

    it "returns only formatted organizations with similar names to selection" do
      subject.should include(matching_organization.name, matching_organization.mailing_city, matching_organization.mailing_state)
    end
  end
end