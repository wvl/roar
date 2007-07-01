class UsersController < ApplicationController
  roar :prefix => "admin" do
    table do
      edit :login
      column :email
      column :name
    end
    
    form do
      text_field :login
      text_field :email
      text_field :name
      fieldset "Password" do
        password_field :password
        password_field :password_confirmation
      end
    end
  end
  
end
