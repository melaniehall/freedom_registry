require "active_record"
require './bootstrap_ar'
require 'io/console'
require './lib/string'
require './lib/formatter'

class Organization < ActiveRecord::Base
  validates :name, :uniqueness => true
  # validates :name, :mailing_city, :mailing_state, :mission_statement, :presence => true

  def self.by_state state_to_find
    Organization.where(mailing_state: state_to_find).order("name ASC")
  end

  def self.by_name name_to_find
    Organization.where("name LIKE '%#{name_to_find}%'").order("name ASC")
  end

  def self.by_keyword(keyword_to_find)
    Organization.where("mission_statement LIKE '%#{keyword_to_find}%'").order("name ASC")
  end

  def self.by_id(organization_id)
    Organization.where(id: "#{organization_id}").first
  end
end
