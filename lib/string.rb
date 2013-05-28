class String
  # colorization
  def colorize(color_code, color_bold= 0)
    "\e[#{color_bold};#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def pink
    colorize(35)
  end

  def dark_grey
    colorize(30, 1)
  end
end