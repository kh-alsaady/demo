class BooksController < ApplicationController
 before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_book_categories, only: [:new, :edit, :index, :display]
  
  def index
    #for add new book using ajax processing
    @book = Book.new    
    #for index processsing
    display = params[:display] || 'all'
                        
    @books = (display == 'all') ? Book.where(user_id: session[:user_id]).order("updated_at DESC") :
                Book.where(user_id: session[:user_id], course_category_id: display).order("updated_at DESC")
    respond_to do  |f|
      f.js{}
      f.html{}
    end
  end

  def show
  end

  def new
    @book = Book.new
    respond_to do |f|
      f.html{}
      f.js{}
    end
  end
  
  def create
    @book         = Book.new(params_book)
    @book.user_id = current_user.id
    @book.category    = CourseCategory.new(name: params[:book_category]) if params[:book_category].present?
    
    if @book.save
      redirect_to books_path
      $state = 'create'
    else
      set_book_categories
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
    updated_params_book = params_book
    
    if params[:book_category].present?
        @book.category = CourseCategory.new(name: params[:book_category])
        updated_params_book.delete('course_category_id')
    end
        
    if @book.update(updated_params_book)    
      redirect_to books_path
      $state = 'update'
    else
      set_book_categories
      render 'edit'  
    end
  end
   
  def destroy
    Book.destroy(params[:id])
    
    respond_to do |f|
      f.js{@books = Book.where(user_id: session[:user_id]).order("updated_at DESC")}
      f.html{redirect_to books_path, notice: 'Book was successfully destroyed.'}
    end       
  end
  
  
  private#-----------------------------------------------------------
  def set_book
    @book = Book.find(params[:id])
  end
  
  def set_book_categories
    @book_categories = CourseCategory.all.map{|course_cat| [course_cat.name, course_cat.id]}.uniq
    @user_book_categories = current_user.books.map{ |book| [book.category.name , book.category.id] if book.category }.compact.uniq
  end
  
  def params_book
    params.require(:book).permit(:title, :started_at, :finshed_at, :completed, :course_category_id, :notes, :created_at, :category)
  end

end
