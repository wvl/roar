class PollsController < ApplicationController
  roar :prefix => "admin" do
    table do
      edit :description
    end
    
    form do
      text_area :description
      has_many :poll_options, :number_blank => 3 do
        text_field :option
      end
    end
  end
  
  roar do
    table do
      edit :description
      column "poll_options.size"
    end
    
    form do
      text_area :description
    end
  end

end