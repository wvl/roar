class PostsController < ApplicationController
  roar :parent=>[:forum,:topic] do
    table do
      edit :id
    end
    
    form do
      text_area :body
    end
  end
end
