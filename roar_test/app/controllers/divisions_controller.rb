class DivisionsController < ApplicationController
  roar :parent=>:league do
      
    table do
      edit :name
      has_many :teams
      delete
    end
    
    form do
      text_field :name
      actions [:save,:save_and_add_another]
    end
  end
end
