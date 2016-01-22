class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_course_categories, only: [:new, :edit, :index, :display]
  
  def index
    #for add new course using ajax processing
    @course = Course.new    
    #for index processsing
    display = params[:display] || 'all'
                        
    @courses = (display == 'all') ? Course.where(user_id: session[:user_id]).order("updated_at DESC") :
                Course.where(user_id: session[:user_id], course_category_id: display).order("updated_at DESC")
    respond_to do  |f|
      f.js{}
      f.html{}
    end
  end

  def show
  end

  def new
    @course = Course.new
    respond_to do |f|
      f.html{}
      f.js{}
    end
  end
  
  def create
    @course         = Course.new(params_course)
    @course.user_id = current_user.id
    @course.category    = CourseCategory.new(name: params[:course_category]) if params[:course_category].present?
    
    if @course.save
      redirect_to courses_path
      $state = 'create'
    else
      set_course_categories
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
    updated_params_course = params_course
    
    if params[:course_category].present?
        @course.category = CourseCategory.new(name: params[:course_category])
        updated_params_course.delete('course_category_id')
    end
        
    if @course.update(updated_params_course)    
      redirect_to courses_path
      $state = 'update'
    else
      set_course_categories
      render 'edit'  
    end
  end
   
  def destroy
    Course.destroy(params[:id])
    
    respond_to do |f|
      f.js{@courses = Course.where(user_id: session[:user_id]).order("updated_at DESC")}
      f.html{redirect_to courses_path, notice: 'Course was successfully destroyed.'}
    end       
  end
  
  #def display
  #  display = params[:display]        
  #  @courses = (display == 'all') ? Course.where(user_id: session[:user_id]).order("updated_at DESC") : Course.where(user_id: session[:user_id], course_category_id: display).order("updated_at DESC")
  #  
  #  respond_to do  |f|
  #    f.js{}
  #  end
  #end
  
  private#-----------------------------------------------------------
  def set_course
    @course = Course.find(params[:id])
  end
  
  def set_course_categories
    @course_categories = CourseCategory.all.map{|course_cat| [course_cat.name, course_cat.id]}.uniq
    @user_course_categories = current_user.courses.map{ |course| [course.category.name , course.category.id] if course.category }.compact.uniq
  end
  
  def params_course
    params.require(:course).permit(:title, :download_link, :completed, :course_category_id, :taked_at, :completed_at, :notes, :created_at, :category)
  end
end
