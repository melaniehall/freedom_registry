module Formatter
  INSTRUCTIONS = "Press q at any time to return to main screen\n"
  NO_RESULTS = "There were no results for your search. Please try again\n\n"
  EXIT_MESSAGE = "THANK YOU FOR USING THE FREEDOM REGISTRY\nFor more information, please visit freedomregistry.org"

  def self.clear_screen
    puts `clear`
  end

  def self.id(id)
    id.to_s.ljust(6)
  end

  def self.name(organization, width)
    name = organization.name

    if name.length < width
      name.ljust(width)
    else
      name[0..(width - 4)] + "..."
    end
  end

  def self.location(organization, width)
    "#{organization.mailing_city}, #{organization.mailing_state}".ljust(width)
  end

  def self.name_header(column_name, width)
    if column_name.length < width
      column_name.ljust(width)
    else
      column_name[0..(width - 4)] + "..."
    end
  end

  def self.location_header(column_name, width)
    column_name.ljust(width)
  end

  def self.table_header(width)
    header = "#{id("ID#")} | %s | #{location_header("LOCATION", 24)}\n"
    remaining_space = (width - header.length) - 2
    header.sub!(/%s/, name_header("ORGANIZATION", remaining_space))
    header << add_hr
  end

  def self.terminal_width
    terminal_width = `tput cols`.to_i
  end

  def self.terminal_height
    terminal_width = `tput lines`.to_i
  end

  def self.add_hr
    line = "-"
    output = line * terminal_width
    output << "\n"
    output.dark_grey
  end

#Output Formatting Methods

  def self.organizations_for_output(organizations)
    if organizations == nil
      output = "There are no results- please try again"
    else
      output = ""
      organizations.each do |organization|
        if !organization.name.nil?
          output << organization_for_list_view(organization, terminal_width) + "\n" + add_hr
        end
      end
    end
    output
  end

  def self.organization_for_list_view(organization, width)
    output = "#{id(organization.id)} | %s | #{location(organization, 25)}"
    remaining_space = (width - output.length) - 2
    output.sub(/%s/, name(organization, remaining_space))
  end

  def self.organization_for_profile_view(organization)
    if organization != nil
      output = "#{organization.name.upcase} | #{location(organization, 25)}"

      output << mission_statement(organization)
      output << website(organization)
      output << "Contact:"
      output << contact_name(organization)
      output << contact_phone(organization)
      output << contact_email(organization)
      output << "\n\n"
    else
      output= "You've entered an incorrect organization id#\n"
    end
    output.yellow
  end

  def self.output(output)
    if output.match(/^exit/)
      puts EXIT_MESSAGE.green
    elsif output != "" && output != nil
      output = INSTRUCTIONS + "\n" + output
      Signal.trap("PIPE", "EXIT")
      IO.popen("less -R", "w") { |f| f.puts output }
    else
      puts output = NO_RESULTS
    end
  end

  #Organization Attribute Validations

  def self.mission_statement(organization)
    mission_statement = ""
    if organization.mission_statement != "NULL" && organization.mission_statement != "" && organization.mission_statement.capitalize != "PENDING"
      mission_statement = "\nMission: " + organization.mission_statement + "\n" + add_hr
    end
    mission_statement
  end

  def self.contact_name(organization)
    contact_name = ""
    if organization.contact_name != "NULL" && organization.contact_name != "" && !organization.contact_name.match(/^Pen/)
      contact_name = "\n" + organization.contact_name
    end
    contact_name
  end

  def self.contact_phone(organization)
    contact_phone = ""
    if organization.contact_phone != "NULL" && organization.contact_phone != "" && organization.contact_phone.capitalize != "PENDING"
      contact_phone = "\n" + organization.contact_phone
    end
    contact_phone
  end

  def self.contact_email(organization)
    contact_email = ""
    if organization.contact_email != "NULL" && organization.contact_email != "" && organization.contact_email.capitalize != "PENDING"
      contact_email = " | " + organization.contact_email
    end
    contact_email
  end

  def self.website(organization)
    website = ""
    if organization.website!= "NULL" && organization.website != ""
      website = "\n" + organization.website
    end
    website
  end

end