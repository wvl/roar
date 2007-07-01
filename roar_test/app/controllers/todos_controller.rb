class TodosController < ApplicationController
  roar :prefix => "admin" do
    order "position"
    per_page 0

    table(:view => "list") do
      action
      edit :description
      boolean :done
      actions { sortable;   done;   undone :name => "Not Done";
        delete_checked :confirm=>"Delete all checked todos?"
      }
    end

    table(:name => "table") do
      action
      edit :description
      boolean :done
      actions do
        done
        undone :name=>"Not Done"
        delete_checked :confirm=>"Delete all checked todos?"
      end
    end
        
    table(:view => "show",  :conditions => "done is NULL or done != 1") {}
    
    new_form do
      text_field :description
      actions [:save_and_add_another, :save]
    end
    
    edit_form do
      text_field :description
      check_box :done
      actions [:save, :destroy]
    end
  end
  
  roar_order(:prefix => "admin")
  
  roar_action(:done, :prefix => "admin") do
    params[:todos].each do |id|
      Todo.find(id).mark_done
    end if params[:todos]
    render :roar_rjs => 'actions/done'
  end
  
  roar_action(:undone, :prefix => "admin") do
    params[:todos].each do |id|
      todo = Todo.find(id)
      todo.update_attribute(:done, false)
      todo.move_to_top
    end if params[:todos]
    render :roar_rjs => 'actions/done'
  end
  
  roar_action(:delete_checked, :prefix => "admin") do
    params[:todos].each do |id|
      Todo.destroy(id)
    end if params[:todos]
    render :roar_rjs => 'actions/done'
  end
  
  def index
    raise "Hey!"
  end
end