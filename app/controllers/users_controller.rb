class UsersController < ApplicationController  
  before_action :set_user, only: [:show, :destroy, :my_profile, :edit, :update]
  
  def index
    @users = User.all    
  end
  
  def display
    display = params[:display] || 'all'
    
    case display
      when 'all'
        @users = User.all
      when 'admin'
        @users = User.where(role_id: 1)
      when 'user'
        @users = User.where(role_id: 2)        
    end
    
  end
  
  
 
  def show    
  end
  
  def set_role
    role_to_set = params[:commit]
    role_id = role_to_set == 'Admin' ? 1 : 2
    
    user_ids_checked = params[:user_ids_checked] || []
    if user_ids_checked.empty?
        @users = User.all
        flash[:notice] = "Select Users to update thier roles First"
        render 'index'
        #redirect_to users_path, notice: "Select Users to update thier roles First"
    else
      user_ids_checked.each do |user_id|
        User.update(user_id, {role_id: role_id})
      end    
      redirect_to users_path, notice: 'Users roles has been updated successfuly'
    end      
  end

 
  def new
    @user = User.new
    render layout: 'public'
  end
    
  def my_profile
    #code
  end
  
  def create        
    @user = User.new(params_user)
    @user.role_id = 2
    if @user.save
        respond_to do |format|
          session[:user_id] = @user.id
          format.html{ redirect_to accounts_path, notice: 'User was created successfully.' }
        end
    else
      render 'new', layout: 'public'
    end    
  end
  
  
  
  def edit
  end
  
  def update          
    if @user.update(params_user)
        respond_to do |format|
          format.html{ redirect_to my_profile_user_path, notice: 'Your Profile has been updated successfully.' }
        end
    else
      render 'edit'
    end    
  end
  
  def destroy
    User.destroy(params[:id])
    
    respond_to do |f|
      f.js{@users = User.order("updated_at DESC")}
      f.html{redirect_to users_path, notice: 'User was successfully destroyed.'}
    end       
  end
  
  private#------------------------------------------------------------
  def set_user
    @user = User.find(params[:id])
  end
  
  def params_user
    params.require(:user).permit(:first_name, :last_name, :display_name, :image, :username, :email, :password, :password_confirmation, :description, :birthdate)
  end
  
end
