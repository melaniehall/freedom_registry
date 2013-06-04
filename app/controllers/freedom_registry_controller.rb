require './bootstrap_ar'
require 'io/console'
require './app/models/organization'
require './lib/string'
require './lib/formatter'


#!/usr/bin/env ruby

class FreedomRegistryController

  def prompt
    @prompt
  end

  def find_by (selection)

    selection = selection.split()
    length = selection.size
    search_type = selection[1]
    search_term = selection[2..length].join("").to_s
    if "#{search_term}" == ""
      puts output = FreedomRegistry::NO_RESULTS
    end
    organizations = Organization.send("by_#{search_type}", "#{search_term}")
    Formatter.organizations_for_output(organizations)
  end

  def list_all
    organizations = Organization.order("name ASC")
    Formatter.organizations_for_output(organizations)
  end

  def view_profile(selection)
    length = selection.length
    organization_id = selection.slice(5..length)
    organization = Organization.by_id(organization_id)
    output = Formatter.organization_for_profile_view(organization)
  end

end