class Todo < ActiveRecord::Base
  acts_as_list
  
  def mark_done
    self.update_attribute(:done, true)
    self.move_to_bottom
  end
end
