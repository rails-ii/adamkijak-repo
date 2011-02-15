class ArticlesController < ApplicationController
  layout "application"
  uses_tiny_mce :options => {
	  :theme => 'advanced',
       :mode =>"textareas",
       :theme_advanced_buttons1 =>"bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
       :theme_advanced_buttons2 =>"cut,copy,paste,pastetext,pasteword,|bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,forecolor,backcolor,|,hr,removeformat,visualaid,|,sub,sup,|,charmap",
 	   :theme_advanced_buttons3 => "",
       :theme_advanced_toolbar_location =>"top",
       :theme_advanced_toolbar_align =>"left",

  }
  before_filter :authenticate_editor!, :except => [:show, :index]

   # Wyświetlanie artykułów z paginacją
   # (GET /articles)
   def index
     @articles = Article.paginate :page => params[:page], :order => 'created_at DESC'
     @categories = Category.all
	 @editors = Editor.all
   end

  # Wyświetlanie artykułu o zadanym id 	
  # (GET /articles/:id)
  def show
    @categories = Category.all
    @article = Article.find(params[:id])
	@editors = Editor.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # Redagowanie nowego arytkułu  
  # (GET /articles/new)
  def new
    @categories = Category.all
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # Edycja arytkułu o zadanym id
  # (GET /articles/1/edit)
  def edit
    @categories = Category.all
    @article = Article.find(params[:id])
  end

  # Utworzenie nowego artykułu, wraz z wyświetleniem informacji o sukcesie
  # (POST /articles)
  def create
    params[:article][:editor_id] = current_editor.id
    @categories = Category.all
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Aktualizacja artykułu o zadanym id
  # (PUT /articles/1)
  def update
    @categories = Category.all
    @article = Article.find(params[:id])

    respond_to do |format|
	  if( current_editor.id == @article.editor_id)
		if @article.update_attributes(params[:article])
		  format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
		  format.xml  { head :ok }
		else
		  format.html { render :action => "edit" }
		  format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
		end
      else
		  format.html { redirect_to(@article, :alert => "You are not the owner of the article.")}
	  end
    end
  end

  # Usunięcie artykułu
  # DELETE /articles/1
  def destroy
    @categories = Category.all
    @article = Article.find(params[:id])
	if( current_editor.id == @article.editor_id)
	  @article.destroy
	else
	  flash[:alert] = "You are not the owner of the article.";
    end

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
