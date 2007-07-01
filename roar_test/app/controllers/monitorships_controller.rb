class MonitorshipsController < ApplicationController
  roar :parent => :topic do
    table do
      edit :"user.name", :name=>"User"
      column :active
      destroy
    end
    
    form do
      auto_complete :user
      check_box :active
      actions [:save_and_add_another,:save,:destroy]
    end
  end
end
