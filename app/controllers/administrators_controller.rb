class AdministratorsController < InheritedResources::Base

  #GET /administrators
  def index 
    @admin = Administrator.all  
  end

  #GET /administrators
  def show 
  end
  
  # GET /administrators/new
  def new 
    @admin = Administrator.new
    @admin.build_user
  end
  
  # GET /administratorss/1/edit 
  def edit
  end
  
  # POST /administrators
  def create 
    @admin = Administrator.new(administrator_params)
   
    respond_to do |format|
      if @admin.save
        format.html { redirect_to root_path, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /administrators/1
  def update
    respond_to do |format|
      if @admin.update(administrator_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /admnistrators/1 
  def destroy 
      @admin.destroy
      respond_to do |format|
          format.html { redirect_to teachers_url, notice: 'Admin was successfully destroyed.' }
          format.json { head :no_content }
      end 
  end

private
  
  def set_administrator
    @admin = Administrator.find( params[:id] ) 
  end

  def administrator_params
    params.require(:administrator).permit(:first_name, :last_name, user_attributes: [:id, :meta_id, :email, :password, :password_confirmation ])
  end
  
  def authenticate_administrator
    redirect_to( new_user_session_path) unless current_user.meta_type == "Administrator"
  end
  
  def new_registration
    redirect_to( administrators_path ) if user_signed_in?  
  end
end

