class CategoriesController < ApplicationController
  roar do
    table do
      edit :name
      delete
    end
    
    form do
      text_field :name      
    end
  end
end
