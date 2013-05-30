require "active_record"

class Program < ActiveRecord::Base
  belongs_to :organizations

end
