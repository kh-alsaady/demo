module ApplicationHelper
  def error_message_for object
    render partial: 'application/error_messages', locals: {object: object}
  end
  
  #def flash_with_toastr
  #  javascript_tag do
  #    toastr.error('message', 'error')      
  #  end
  #end  
    #flash[:error] = 'error'
    #flash.each do |type, msg|
    #  if ['success', 'warning', 'error', 'info'].include? type
    #    javascript_tag do
    #      toastr.error('message', 'error');
    #      #toastr.key(msg, key);
    #    end
    #  else
    #    
    #  end
    #end
  
end
