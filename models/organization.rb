require "active_record"
require './bootstrap_ar'
require 'io/console'
require './lib/string'
require './lib/formatter'

class Organization < ActiveRecord::Base
  include Formatter

  def self.formatter
    Formatter
  end

  def self.by_state state_to_find
    Organization.where(mailing_state: state_to_find)
  end

  def self.by_name name_to_find
    Organization.where("name LIKE '%#{name_to_find}%'")
  end

  def self.by_keyword(keyword_to_find)
    Organization.where("mission_statement LIKE '%#{keyword_to_find}%'")
  end

  def self.find_keyword(keyword_to_find)
    output = "Search by Keyword feature is coming soon"
  end

  def self.view_profile(organization_id)
    organization = Organization.where(id: "#{organization_id}")
    organization.find_each do |organization|
      output = "\n\n#{organization.name.upcase} | #{organization.mailing_city}, #{organization.mailing_state}" +
      "\nMission: #{organization.mission_statement}\n"
    end
    output
  end

  def self.format_organizations_for_output organizations
    output = ""
    organizations.each do |organization|
      if !organization.name.nil?
        output << format_organization_for_list_view(organization)
      end
    end
    output
  end

  def self.format_organization_for_list_view organization
    formatter.format_id(organization.id) + " | " + formatter.format_name(organization.name) + " | LOCATION: #{organization.mailing_city}, #{organization.mailing_state}\n" + formatter.add_hr
  end

  def self.format_organization_for_profile_view organization
    output = formatter.format_name(organization.name) + "\n | LOCATION: #{organization.mailing_city}, #{organization.mailing_state}\n" + formatter.add_hr
    output << "MISSION STATEMENT: #{organization.mission_statement}"
  end
end
