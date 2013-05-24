module Formatter
  INSTRUCTIONS = "Press q at any time to return to main screen\n"
  NO_RESULTS = "\nThere were no results for your search. Please try again\n"

  def self.clear_screen
    puts `clear`
  end

  def self.format_name(string)
    string.prepend("    ")
    string.ljust(70)
  end

  def self.format_id(id)
    id.to_s.ljust(6)
  end

  def self.terminal_width
    terminal_width = `tput cols`.to_i
  end

  def self.terminal_height
    terminal_width = `tput lines`.to_i
  end

  def self.add_hr
    line = "-"
    output = "\n"
    output << line * terminal_width
    output << "\n\n"
  end

  def self.format_output output
    if output != nil
      output.prepend(INSTRUCTIONS + "\n")
      IO.popen("less", "w") { |f| f.puts output }
    end
    # exec 'less output'
    output = NO_RESULTS
  end

end