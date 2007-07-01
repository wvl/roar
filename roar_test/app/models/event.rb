class Event < ActiveRecord::Base
  belongs_to :category
  before_validation :set_category
  attr_writer :category_id
  validates_presence_of :category_id
  
  def set_category
    self.category = Category.find(@category_id) unless @category_id.empty?
  end
end
