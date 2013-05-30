require "active_record"

class Favorite < ActiveRecord::Base
  belongs_to :organizations

end
