require './bootstrap_ar'
require 'io/console'
require './models/organization'
require './lib/string'
require './lib/formatter'


#!/usr/bin/env ruby

class FreedomRegistryController

  def prompt
    @prompt
  end

  def find_by_state(selection)
    length = selection.length
    state_to_find = selection.slice(11..length)
    if state_to_find != ""
      organizations = Organization.by_state(state_to_find)
      output = Formatter.organizations_for_output(organizations)
    else
    puts output = FreedomRegistry::NO_RESULTS
    end
    output
  end

  def find_by_name(selection)
    length = selection.length
    name_to_find = selection.slice(10..length)
    if name_to_find != ""
      organizations = Organization.by_name(name_to_find)
      output = Formatter.organizations_for_output(organizations)
    else
    puts output = FreedomRegistry::NO_RESULTS
    end
    output
  end

  def find_by_keyword(selection)
    length = selection.length
    keyword_to_find = selection.slice(13..length)
    if keyword_to_find != ""
      organizations = Organization.by_keyword(keyword_to_find)
      output = Formatter.organizations_for_output(organizations)
    else
      puts output = FreedomRegistry::NO_RESULTS
    end
    output
  end

  def list_all
    organizations = Organization.order("name ASC")
    output = Formatter.organizations_for_output(organizations)
  end

  def view_profile(selection)
    length = selection.length
    organization_id = selection.slice(5..length)
    organization = Organization.by_id(organization_id)
    output = Formatter.organization_for_profile_view(organization)
  end

end