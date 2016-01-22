class PublicController < ApplicationController
  layout 'public'
  
  def index
    @users = User.all.order("created_at DESC")
  end
  
  def about_me
  end
  
  def contact_me
    if request.post?
        # send email processing
        flash[:notice] = 'done'
    end
    
    
  end
end
