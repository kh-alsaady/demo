class AdminController < ApplicationController  
  
  def index    
  end

  def new
    render 'login', layout: 'public'
  end
  
  def create
    #login processing
    if params[:username].present? && params[:password].present?
      found_user = User.authenticate(params[:username], params[:password])
      if found_user
        #mark  user as loggedin
        session[:user_id] = found_user.id        
        redirect_to accounts_path, notice: 'You Logged In Successfully'
      else
        flash[:notice] = 'Username And Password Combination were Invalid'
        render 'login', layout: 'public'
      end      
    else
      flash[:notice] = 'Enter Username and Password First'
      render 'login', layout: 'public'
    end
    
    
  end   
  
  
  
  def destroy
    #logout processing
    session[:user_id] = nil
    redirect_to login_path, notice: "You Are Now Logged Out"
  end
  
  
  def change_password
    if request.get?      
    elsif request.patch?
      #change password processing
      if params[:old_password].present? && params[:new_password].present? && params[:confirm_new_password].present?
        if current_user.authenticated?(params[:old_password])
          if params[:new_password] == params[:confirm_new_password]
            current_user.password = params[:new_password]
            if current_user.save
              redirect_to accounts_path, notice: "Your Password has been changed successfully"
            else
              flash[:notice] = "An error occured while trying changing your password"
            end
          else
            flash[:notice] = "New password and old password doesn't match"
          end
        else
          flash[:notice] = "You Should Enter Correct Old Password First"
        end
      else
        flash[:notice] = "Fill All Fields First"
      end
    end
  end

  def search    
     search_text = "%#{params[:search_text]}%"
    
     account_types_ids = AccountType.where(["name LIKE ?", search_text]).map{|acc_type| acc_type.id}
     @accounts = current_user.accounts.where(["username LIKE ? OR email LIKE ? OR password LIKE ? OR notes LIKE ? OR other_emails LIKE ? OR reason_create LIKE ? OR account_type_id in (?)", search_text, search_text, search_text, search_text, search_text, search_text, account_types_ids ])
     
     course_category_ids = CourseCategory.where(["name LIKE ?", search_text]).map{|cat| cat.id}
     completed = params[:search_text].downcase  == 'yes' ? true : false
     #to exclude search by completed if user not search about that --typing yes or no--
     completed = nil if (params[:search_text].downcase != 'yes') && (params[:search_text].downcase != 'no')
     
     @courses = current_user.courses.where(["title LIKE ? OR download_link LIKE ? OR notes LIKE ? OR completed = ? OR course_category_id in (?)", search_text, search_text, search_text, completed, course_category_ids ])        
     @books   = current_user.books.where(["title LIKE ? OR notes LIKE ? OR completed = ? OR course_category_id in (?)", search_text, search_text, completed, course_category_ids ])
     
     @results         = @accounts.count + @courses.count + @books.count
   
  end
end

