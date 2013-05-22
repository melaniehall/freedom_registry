require_relative 'bootstrap_ar'
require 'io/console'
require './models/organization'
require './lib/string'

#!/usr/bin/env ruby

class FreedomRegistry

  WELCOME_MESSAGE = "Welcome to the Freedom Registry CLI \n\nTo SEARCH BY STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo FIND BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\n\n"
  PROMPT = "To SEARCH BY STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  WRONG_INPUT = "You have entered an incorrect input, please try again."
  STATE_PROMPT = "To VIEW an organization's profile, enter 'view id_number' (ie: 'view 45')\n to SEARCH BY ANOTHER STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  KEYWORD_PROMPT = "To VIEW an organization's profile, enter 'view id_number' (ie: 'view 45')\n to SEARCH BY ANOTHER KEYWORD, enter: 'find keyword *keyword*' (ie: find keyword prevention)\nTo SEARCH BY STATE, enter 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  NAME_PROMPT = "To VIEW an organization's profile, enter 'view id_number' (ie: 'view 45')\n To SEARCH FOR ANOTHER NAME, enter: find name *name_of_organization* (ie: 'find name Abolition International')\nTo SEARCH BY STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  LIST_PROMPT = "To VIEW an organization's profile, enter 'view id_number' (ie: 'view 45')\n to SEARCH BY ANOTHER STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo EXIT the Freedom Registry, enter 'exit'\n"
  DETAIL_PROMPT = "To SEARCH BY STATE, enter: 'find state *STATE*' (ie: find state TN)\nTo SEARCH BY NAME, enter 'find name 'NAME'*' (ie: find name 'Abolition International')\nTo LIST ALL organizations, enter 'list all'\nTo EXIT the Freedom Registry, enter 'exit'\n"
  NO_POSITION = "no position prompt goes here"
  THANK_YOU_MESSAGE = "THANK YOU FOR USING FREEDOM REGISTRY CLI."
  NO_RESULTS = "\nThere were no results for your search. Please try again\n"

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

 def self.output_user_selection(selection)
    length = selection.length
    output = ""
    case
      when selection.match(/^find state\s/)
        state_to_find = selection.slice(11..length)

        organizations = Organization.where(mailing_state: "#{state_to_find}")
        organizations.find_each do |project|
          output << "#{project.id}  | #{project.name.center(50)} | LOCATION: #{project.mailing_city}, #{project.mailing_state}\n\n"
        end
        # organizations.view :class=>:object_table, :fields=> [:name, :mailing_city]

      when selection.match(/^find name\s/)
        name_to_find = selection.slice(10..length)
        organizations = Organization.where("name LIKE '#{name_to_find}%'")
        organizations.find_each do |project|
          output << "#{project.id}  | #{project.name.center(50)} | LOCATION: #{project.mailing_city}, #{project.mailing_state}\n\n"
        end

      when selection.match(/^find keyword\s/)
        keyword = selection.slice(13..length)
        output << "Search by Keyword feature is coming soon"

      when selection.match(/^list all/)
        Organization.all.each do |project|
          if !project.name.nil? && !project.mailing_state.nil? && !project.mailing_city.nil?
            output << "#{project.id}  | #{project.name.center(50)} | LOCATION: #{project.mailing_city}, #{project.mailing_state}\n\n"
          end
        end

      when selection.match(/^view\s/)
        organization_id = selection.slice(5..length)
        organization = Organization.where(id: "#{organization_id}")
        organization.find_each do |organization|
          output << "\n\n#{organization.name.upcase} | #{organization.mailing_city}, #{organization.mailing_state}" +
          "\nMission: #{organization.mission_statement}\n"
        end

      when selection.match(/exit/)
        puts THANK_YOU_MESSAGE.green
        abort

      else
        output << " "
    end

    output << NO_RESULTS if output == ""
    output
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
