require_relative 'bootstrap_ar'
require 'io/console'
require './models/organization'
require './lib/string'
require './controllers/freedom_registry_controller.rb'
require './lib/formatter'

#!/usr/bin/env ruby

class FreedomRegistry

  attr_accessor :current_position

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
 WELCOME_MESSAGE = "Welcome to the Freedom Registry\n\n" +
 "Search through organizations in the registry using the commands below:\n" +
   "list all .......................(List all)\n" +
   "find name 'name goes here'......(Search by name, ie: 'find name Abolition International')\n" +
   "find state 'state'..............(Search by state abbreviation, ie: 'find state TN')\n" +
   "find keyword 'keyword'..........(Search by keyword, ie: 'find keyword prevention')\n" +
   "view 'organization id#'.........(View an organization's profile, ie: 'view 128')"


  def initialize
    self.current_position = "welcome"
  end

  def self.controller
    controller = FreedomRegistryController.new
  end

  def prompt_user_for_input
    prompt = prompt_user_for_selection(current_position)
    puts prompt
    input = gets.chomp
    self.current_position = find_current_position(input)
  end

 def find_current_position(selection)
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
        position = "exit"

      when selection.match(/^view\s/)
        organization_id = selection.slice(5..length)
        position = "view #{organization_id}"
      else
        position = "wrong_input"
    end
    self.current_position = position
  end

  def self.table_header(view_type)
    if view_type == "list_view"
      header = formatter.format_id("ID#") + " | " + formatter.format_name("ORGANIZATION NAME") + " |     LOCATION"
      header << formatter.add_hr
    elsif view_type == "detail_view"
      header = "VIEW ORGANIZATION\n"
    end
  end

  # def output_user_selection(selection)
  #   length = selection.length
  #   output = ""
  #   case

  #     # when selection.match(/^view\s/)
  #     #   organization_id = selection.slice(5..length)
  #     #   organization = Organization.where(id: "#{organization_id}")
  #     #   organization.find_each do |organization|
  #     #     output << "\n\n#{organization.name.upcase} | #{organization.mailing_city}, #{organization.mailing_state}" +
  #     #     "\nMission: #{organization.mission_statement}\n"
  #     #   end

  #     when selection.match(/exit/)
  #       formatter.clear_screen

  #       puts THANK_YOU_MESSAGE.green

  #     else
  #       output << " "
  #   end

  #   output << NO_RESULTS if output == ""
  #   output.prepend(Formatter::INSTRUCTIONS + "\n")
  #   IO.popen("less", "w") { |f| f.puts output } unless output == ""

  # end

  def prompt_user_for_selection(current_position)
    # current_position ="welcome"
    case
      when current_position.match(/welcome/)
        prompt = WELCOME_MESSAGE

      when current_position.match(/^find state\s/)
        prompt = STATE_PROMPT

      when current_position.match(/^find name\s/)
        prompt = NAME_PROMPT

      when current_position.match(/^find keyword\s/)
        prompt = KEYWORD_PROMPT

      when current_position.match(/^list all/)
        prompt = LIST_PROMPT

      when current_position.match(/wrong_input/)
        prompt = PROMPT

      when current_position.match(/^view\s/)
        prompt = DETAIL_PROMPT

      else
        prompt = NO_POSITION
    end
    prompt.yellow
  end

end

if __FILE__ == $0
  freedom_registry = FreedomRegistry.new
  controller = FreedomRegistryController.new

  while input = freedom_registry.prompt_user_for_input do

    if input.match(/^find state\s/)
      output = controller.find_by_state(input)
    elsif input.match(/^find name\s/)
      output = controller.find_by_name(input)
    elsif input.match(/^find keyword\s/)
      output = controller.find_by_keyword(input)
    elsif input.match(/^list all/)
      output = controller.list_all
    elsif input.match(/^view\s/)
      output = controller.view_profile(input)
    elsif input.match(/^exit/)
      output = "exit"
    else
      output = ""
      FreedomRegistry::WRONG_INPUT
    end
    #OUTPUT
    output.prepend(Formatter.table_header(Formatter.terminal_width).yellow) unless input.match(/^view\s/) || input.match(/^exit/) || output == ""
    Formatter.clear_screen
    Formatter.output(output)
    break if input == "exit"
  end
end