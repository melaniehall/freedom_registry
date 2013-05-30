require_relative 'bootstrap_ar'
require 'io/console'
require './app/models/organization'
require './lib/string'
require './app/controllers/freedom_registry_controller.rb'
require './lib/formatter'

#!/usr/bin/env ruby

class FreedomRegistry

  attr_accessor :current_position

  WELCOME_MESSAGE = "\nWelcome to the Freedom Registry\n\n" +
  "Search through organizations in the registry using the commands below:\n" +
   "  by name 'name goes here'........(Search by name, ie: 'find name Abolition International')\n" +
   "  by state 'state'................(Search by state abbreviation, ie: 'find state TN')\n" +
   "  by keyword 'keyword'............(Search by keyword, ie: 'find keyword prevention')\n" +
   "  view 'organization id#'.........(View an organization's profile, ie: 'view 128')\n" +
   "  list all .......................(List all)\n"

  MAIN_PROMPT = "To view an organization's profile:\n" +
   "  view 'organization id#'.........(View an organization's profile, ie: 'view 128')\n" +
   "To search again:\n" +
   "  by name 'name goes here'........(Search by name, ie: 'find name Abolition International')\n" +
   "  by state 'state'................(Search by state abbreviation, ie: 'find state TN')\n" +
   "  by keyword 'keyword'............(Search by keyword, ie: 'find keyword prevention')\n" +
   "  list all .......................(List all)\n" +
   "  exit ...........................(Quit the program)\n"

  DETAIL_PROMPT = "To view another organization's profile:\n" +
   "  view 'organization id#'..........(View an organization's profile, ie: 'view 128')\n" +
   "To search again:\n" +
   "  by name 'name goes here'........(Search by name, ie: 'find name Abolition International')\n" +
   "  by state 'state'................(Search by state abbreviation, ie: 'find state TN')\n" +
   "  by keyword 'keyword'............(Search by keyword, ie: 'find keyword prevention')\n" +
   "  list all .......................(List all)\n" +
   "  exit ...........................(Quit the program)\n"
  WRONG_INPUT = "You have entered an incorrect input, please try again."
  NO_POSITION = "no position prompt goes here"
  THANK_YOU_MESSAGE = "THANK YOU FOR USING THE FREEDOM REGISTRY"
  NO_RESULTS = "\nThere were no results for your search. Please try again\n"


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
    when selection.match(/^by state\s/)
      state_to_find = selection.slice(9..length)
      position = "by state #{state_to_find}"

    when selection.match(/^by name\s/)
      name_to_find = selection.slice(8..length)
      position = "by name #{name_to_find}"

    when selection.match(/^by keyword\s/)
      keyword = selection.slice(11..length)
      position = "by keyword #{keyword}"

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

  def prompt_user_for_selection(current_position)
    case
      when current_position.match(/welcome/)
        prompt = WELCOME_MESSAGE

      when current_position.match(/^by state\s/)
        prompt = MAIN_PROMPT

      when current_position.match(/^by name\s/)
        prompt = MAIN_PROMPT

      when current_position.match(/^by keyword\s/)
        prompt = MAIN_PROMPT

      when current_position.match(/^list all/)
        prompt = MAIN_PROMPT

      when current_position.match(/wrong_input/)
        prompt = MAIN_PROMPT

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

    if input.match(/^by state\s/)
      output = controller.find_by_state(input)
    elsif input.match(/^by name\s/)
      output = controller.find_by_name(input)
    elsif input.match(/^by keyword\s/)
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