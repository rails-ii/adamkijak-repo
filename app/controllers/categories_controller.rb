class CategoriesController < ApplicationController
  layout "application"
  before_filter :authenticate_editor!, :except => [:show, :index]

  # Wyświetlanie kategorii
  # GET /categories
  def index
    @categories = Category.all
	@editors = Editor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # Wyświetlanie kategorii o zadanym id
  # GET /categories/1
  def show
    @category = Category.find(params[:id])
	@editors  = Editor.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # Redagowanie nowej kategorii 
  # GET /categories/new
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # Edycja kategorii o zadanym id
  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # Utworzenie nowej kateogrii, wraz z wyświetleniem informacji o sukcesie
  # POST /categories
  def create
    params[:category][:editor_id] = current_editor.id
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Aktualizacja kategorii o zadanym id
  # PUT /categories/1
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
	  if( current_editor.id == @category.editor_id)
		if @category.update_attributes(params[:category])
		  format.html { redirect_to(@category, :notice => 'Category was successfully updated.') }
		  format.xml  { head :ok }
		else
		  format.html { render :action => "edit" }
		  format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
		end
	  else
		format.html { redirect_to(@category, :alert => "You are not the owner of the category.")}
      end
    end
  end

  # Usunięcie kategorii 
  # DELETE /categories/1
  def destroy
    @category = Category.find(params[:id])
	if( current_editor.id == @category.editor_id)
      @category.destroy
	else
	  flash[:alert] = "You are not the owner of the category.";
    end

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
