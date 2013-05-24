module Formatter

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

end