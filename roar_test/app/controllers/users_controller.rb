class UsersController < ApplicationController
  roar do
    filter :search, :text, :fields => [:login, :email, :name]
    
    table do
      edit :login, :type => :single
      column :email
      column :name do |test| "name: #{test}"; end
      column :name do truncate(@column_attribute, 7); end
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
      
  roar_auto_complete [:login,:email,:name]

  # render new.rhtml
#   def new
#   end

#   def create
#     @user = User.new(params[:user])
#     @user.save!
#     self.current_user = @user
#     redirect_back_or_default('/')
#     flash[:notice] = "Thanks for signing up!"
#   rescue ActiveRecord::RecordInvalid
#     render :action => 'new'
#   end

end
