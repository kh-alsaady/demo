class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :set_account_types, only: [:new, :edit, :index, :display]
  
  def index
    #for add new account using ajax 
    @account = Account.new
    
    display = params[:display] || 'all'
                        
    @accounts = (display == 'all') ? Account.where(user_id: session[:user_id]).order("updated_at DESC") :
                Account.where(user_id: session[:user_id], account_type_id: display).order("updated_at DESC")
    respond_to do  |f|
      f.js{}
      f.html{}
    end
  end

  def show
  end

  def new
    @account = Account.new
    respond_to do |f|
      f.html{}
      f.js{}
    end
    
  end
  
  def create
    @account         = Account.new(params_account)
    @account.user_id = current_user.id
    @account.type    = AccountType.new(name: params[:account_type]) if params[:account_type].present?
    
    if @account.save
      flash[:success] = 'The account has been Successfully created'
      redirect_to accounts_path
      #$state = 'create'
    else
      set_account_types
      render 'new'  
    end    
  end

  def edit
    respond_to do |f|
      f.html{}
      f.js{}
    end
  end
  
  def update
    updated_params_account = params_account
    
    if params[:account_type].present?
        @account.type = AccountType.new(name: params[:account_type])
        updated_params_account.delete('account_type_id')
    end
        
    if @account.update(updated_params_account)
      flash[:success] = 'The account has been Successfully updated'
      redirect_to accounts_path
      #$state = 'update'
    else
      set_account_types
      render 'edit'  
    end
  end
   
  def destroy
    Account.destroy(params[:id])
    
    respond_to do |f|
      f.js{@accounts = Account.where(user_id: session[:user_id]).order("updated_at DESC")}
      f.html{redirect_to accounts_path, notice: 'Account was successfully destroyed.'}
    end       
  end
  
  #def display
  #  display = params[:display]        
  #  @accounts = (display == 'all') ? Account.where(user_id: session[:user_id]).order("updated_at DESC") : Account.where(user_id: session[:user_id], account_type_id: display).order("updated_at DESC")
  #  
  #  respond_to do  |f|
  #    f.js
  #  end
  #end
  
  private#-----------------------------------------------------------
  def set_account
    @account = Account.find(params[:id])
  end
  
  def set_account_types
    @account_types = AccountType.all.map{|acc_type| [acc_type.name, acc_type.id]}.uniq
    @user_account_types = current_user.accounts.map{ |acc| [acc.type.name , acc.type.id] if acc.type}.compact.uniq
  end
  
  def params_account
    params.require(:account).permit(:username, :email, :password, :account_type_id, :other_emails, :reason_create, :notes, :created_at, :type)
  end
  
end