class EventsController < ApplicationController
  roar do
    per_page 5
    order "date DESC"
    
    table do
      edit :title, :type=>:modalbox
      column :date
      column :"category.name" 
      link :"category.name" do "#{edit_category_path(@record.category)}"; end
      show
      show "View", :type=>:single
      show "Popup", :type=>:modalbox
      destroy
      action
      actions { delete_checked :confirm=>"Delete all checked events?"  }
    end
    
    new_form do
      text_field :title
      text_area :body
      select_and_add :category_id, :choices=>Category.to_select, :prompt=>"Category:"
      datetime_select :date
      actions [:save, :save_and_add_another, :save_and_continue_editing, :delete]
    end
    
    edit_form do
      text_field :title
      text_area :body
      select_and_add :category_id, :choices=>Category.to_select, :prompt=>"Category:"
      datetime_select :date
      preview_link :preview
      actions [:save, :save_and_continue_editing, :delete]
    end
  end
  
  roar_action :preview do
    @event = Event.new(params[:event])
    respond_to do |format|
      format.js { render :partial => "preview" }
    end
  end

  roar_action(:delete_checked) do
    params[:events].each do |id|
      Event.destroy(id)
    end if params[:events]
    render :roar_rjs => 'actions/done'
  end
  
end
