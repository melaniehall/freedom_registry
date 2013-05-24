require './bootstrap_ar'
require 'io/console'
require './models/organization'
require './lib/string'


#!/usr/bin/env ruby

class FreedomRegistryController
  include Formatter


  def prompt
    @prompt
  end

  def find_by_state selection
    length = selection.length
    state_to_find = selection.slice(11..length)
    if state_to_find != ""
      organizations = Organization.by_state(state_to_find)
      output = Organization.format_organizations_for_output(organizations)
      # Formatter.format_output(output)
    else
    puts output = FreedomRegistry::NO_RESULTS
    end
    output
  end

  def find_by_name selection
    length = selection.length
    name_to_find = selection.slice(10..length)
    if name_to_find != ""
      organizations = Organization.by_name(name_to_find)
      output = Organization.format_organizations_for_output(organizations)
      # Formatter.format_output(output)
    else
    puts output = FreedomRegistry::NO_RESULTS
    end
    output
  end

  def self.prompt_user_for_input(current_position= "welcome")
    puts prompt_user_for_selection(current_position)
    selection = gets.chomp
    puts output_user_selection(selection)
    position = find_current_position(selection)
    prompt_user_for_input(position)
  end

 def self.find_current_position(selection)
    length = selection.length
    position = ""

    case
      when selection.match(/^find state\s/)
        state_to_find = selection.slice(11..length)
        position = "find state #{state_to_find}"

      when selection.match(/^find name\s/)
        name_to_find = selection.slice(10..length)
        position = "find name #{name_to_find}"

      when selection.match(/^find keyword\s/)
        keyword = selection.slice(13..length)
        position = "find keyword #{keyword}"

      when selection.match(/^list all/)
        position = "list all"

      when selection.match(/exit/)
        puts "thank you for using FR"
        abort

      when selection.match(/^view\s/)
        organization_id = selection.slice(5..length)
        position = "view #{organization_id}"
      else
        position = "wrong_input"
    end
    position
  end

  def self.table_header(view_type)
    if view_type == "list_view"
      header = format_id("ID#") + " | " + format_name("ORGANIZATION NAME") + " |     LOCATION"
      header << add_hr
    elsif view_type == "detail_view"
      header = "VIEW ORGANIZATION\n"
    end
  end

  def self.output_user_selection(selection)
    length = selection.length
    output = ""
    case
      when selection.match(/^find state\s/)
        state_to_find = selection.slice(11..length)
        organizations = Organization.by_state(state_to_find)
        organization.each do |organization|
          output << organization.format_organizations_for_output
        end

      when selection.match(/^find name\s/)
        name_to_find = selection.slice(10..length)
        output << Organization.find_name(name_to_find)

      when selection.match(/^find keyword\s/)
        keyword_to_find = selection.slice(13..length)
        output << Organization.find_keyword(keyword_to_find)

      when selection.match(/^list all/)
        clear_screen


      when selection.match(/^view\s/)
        organization_id = selection.slice(5..length)
        organization = Organization.where(id: "#{organization_id}")
        organization.find_each do |organization|
          output << "\n\n#{organization.name.upcase} | #{organization.mailing_city}, #{organization.mailing_state}" +
          "\nMission: #{organization.mission_statement}\n"
        end

      when selection.match(/exit/)
        clear_screen

        puts THANK_YOU_MESSAGE.green
        abort

      else
        output << " "
    end

    output << NO_RESULTS if output == ""
    output.prepend
    output.prepend(INSTRUCTIONS + "\n")
    IO.popen("less", "w") { |f| f.puts output } unless output == ""

  end

  def prompt_user_for_selection(position)
    case
      when position.match(/welcome/)
        prompt = WELCOME_MESSAGE

      when position.match(/^find state\s/)
        prompt = STATE_PROMPT

      when position.match(/^find name\s/)
        prompt = NAME_PROMPT

      when position.match(/^find keyword\s/)
        prompt = KEYWORD_PROMPT

      when position.match(/^list all/)
        prompt = LIST_PROMPT

      when position.match(/wrong_input/)
        prompt = WRONG_INPUT

      when position.match(/^view\s/)
        prompt = DETAIL_PROMPT

      else
        prompt = NO_POSITION
    end
    prompt
  end

end

if __FILE__ == $0
FreedomRegistry.prompt_user_for_input()
end
