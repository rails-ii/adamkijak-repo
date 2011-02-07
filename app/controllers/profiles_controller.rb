class ProfilesController < ApplicationController
  before_filter :authenticate_editor!, :except => [:show, :index]
  # GET /profiles
  # GET /profiles.xml
  def index
    @profiles = Profile.all
	@editors  = Editor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @profile = Profile.find(params[:id])
	@editors = Editor.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
	  if( current_editor.id == @profile.editor_id)
		if @profile.update_attributes(params[:profile])
		  format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
		  format.xml  { head :ok }
		else
		  format.html { render :action => "edit" }
		  format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
		end
	  else
		format.html { redirect_to(@profile, :notice => "You are not owner of the profile.")}
	  end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end
