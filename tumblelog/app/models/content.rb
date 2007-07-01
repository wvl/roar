class Content < ActiveRecord::Base
  include ActionView::Helpers::TagHelper, ActionView::Helpers::TextHelper, WhiteListHelper
  
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  
  before_save :format_content
  before_save :set_user
  
  serialize :metadata

  attr_writer :tag_list, :new_tags, :edit_tags
  def tag_list
    tags.map(&:name).join(' ')
  end

  after_save :create_tags_from_list, :create_tags_from_roar

protected

  def create_tags_from_roar
    tags.delete tags.select {|t| !@edit_tags.has_key?(t.id.to_s) } if @edit_tags 
    @edit_tags.each { |key, params|
      Tag.find(key).update_attributes(params)
    } unless @edit_tags.blank?
    (@new_tags || []).each { |params|
      Tag.find_or_create_by_name(params[:name]).taggables << self if params[:name].strip != ""
    }
  end

  def create_tags_from_list
    @tag_list.split(" ").each do |tag|
      Tag.find_or_create_by_name(tag).taggables << self
    end unless @tag_list.blank?
  end
    

  def set_user
    self.created_by_id = User.current_user.id if new_record?
    self.updated_by_id = User.current_user.id
  end
  
  def format_content
    body.strip!
    self.body_html = white_list(RedCloth.new(auto_link(body) { |text| truncate(text, 50) }).to_html)
  end
end
