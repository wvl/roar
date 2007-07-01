class SinksController < ApplicationController
  roar do
    table do
      edit :name
    end
    
    form do
      text_field :name
      text_area :body
      password_field :protected_by, :style=>"width: 200px;"
      file_field :attachment
      select_field :status, :choices=>[["on", "on"], ["off", "off"]]
      date_select :purchased_on
      datetime_select :washed_at
      fieldset "extra fields" do
        check_box :shiny
        radio_buttons :style, :choices=>[["single", "Single"], ["double", "Double"]]
      end
    end
    
    #   select_field :status, 
    # end
  end
end
