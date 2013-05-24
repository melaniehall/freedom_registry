require_relative 'bootstrap_ar'
require 'io/console'
require './models/organization'
require './lib/string'
require './controllers/freedom_registry_controller.rb'


#!/usr/bin/env ruby

class FreedomRegistry
  include Formatter

  WELCOME_MESSAGE = "Welcome to the Freedom Registry CLI \n\nTo SEARCH BY STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo FIND BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\n\n"
  PROMPT = "To SEARCH BY STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  WRONG_INPUT = "You have entered an incorrect input, please try again."
  STATE_PROMPT = "To VIEW an organization's profile, enter 'view id_number' (ie: 'view 45')\nTo SEARCH BY ANOTHER STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  KEYWORD_PROMPT = "To VIEW an organization's profile, enter 'view id_number' (ie: 'view 45')\nTo SEARCH BY ANOTHER KEYWORD, enter: 'find keyword *keyword*' (ie: find keyword prevention)\nTo SEARCH BY STATE, enter 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  NAME_PROMPT = "To VIEW an organization's profile, enter 'view id_number' (ie: 'view 45')\nTo SEARCH FOR ANOTHER NAME, enter: find name *name_of_organization* (ie: 'find name Abolition International')\nTo SEARCH BY STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  LIST_PROMPT = "To VIEW an organization's profile, enter 'view id_number' (ie: 'view 45')\nTo SEARCH BY ANOTHER STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo EXIT the Freedom Registry, enter 'exit'\n"
  DETAIL_PROMPT = "To SEARCH BY STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  NO_POSITION = "no position prompt goes here"
  THANK_YOU_MESSAGE = "THANK YOU FOR USING FREEDOM REGISTRY CLI."
  NO_RESULTS = "\nThere were no results for your search. Please try again\n"


  def self.formatter
    Formatter
  end

  def self.controller
    controller = FreedomRegistryController.new
  end


  def self.prompt_user_for_input(current_position= "welcome")
    puts prompt_user_for_selection(current_position)
    selection = gets.chomp
    if selection.match(/^find state\s/)
      output = controller.find_by_state(selection)
    elsif selection.match(/^find name\s/)
      output = controller.find_by_name(selection)
    else
      puts output_user_selection(selection)
    end
    #OUTPUT
    formatter.clear_screen
    formatter.format_output(output)

    #LOOP
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
      header = formatter.format_id("ID#") + " | " + formatter.format_name("ORGANIZATION NAME") + " |     LOCATION"
      header << formatter.add_hr
    elsif view_type == "detail_view"
      header = "VIEW ORGANIZATION\n"
    end
  end

  def self.output_user_selection(selection)
    length = selection.length
    output = ""
    case
      when selection.match(/^find keyword\s/)
        keyword_to_find = selection.slice(13..length)
        organizations = Organization.by_keyword(keyword_to_find)
        output << Organization.format_organizations_for_output(organizations)

      when selection.match(/^list all/)
        organizations = Organization.all
        output << Organization.format_organizations_for_output(organizations)


      when selection.match(/^view\s/)
        organization_id = selection.slice(5..length)
        organization = Organization.where(id: "#{organization_id}")
        organization.find_each do |organization|
          output << "\n\n#{organization.name.upcase} | #{organization.mailing_city}, #{organization.mailing_state}" +
          "\nMission: #{organization.mission_statement}\n"
        end

      when selection.match(/exit/)
        formatter.clear_screen

        puts THANK_YOU_MESSAGE.green
        abort

      else
        output << " "
    end

    output << NO_RESULTS if output == ""
    output.prepend(Formatter::INSTRUCTIONS + "\n")
    IO.popen("less", "w") { |f| f.puts output } unless output == ""

  end

  def self.prompt_user_for_selection(position)
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
    prompt.yellow
  end

end

if __FILE__ == $0
FreedomRegistry.prompt_user_for_input()
end
