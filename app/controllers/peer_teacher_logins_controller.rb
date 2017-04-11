class PeerTeacherLoginsController < InheritedResources::Base
#GET /login_user
    def index 
       @peer_teacher_login = PeerTeacherLogin.all  
    end

    #GET /peer_teacher_login
    def show 
    end
    
    # GET /peer_teacher_login/new
    def new 
       @peer_teacher_login = PeerTeacherLogin.new
       @peer_teacher_login.build_user
    end
    
    # GET /peer_teacher_login/1/edit 
    def edit
    end
    
    # POST /peer_teacher_login
    def create 
       @peer_teacher_login = PeerTeacherLogin.new(peer_teacher_login_params)
       
        respond_to do |format|
            if @peer_teacher_login.save
                format.html { redirect_to root_path, notice: 'Peer Teacher User was successfully created.' }
                format.json { render :show, status: :created, location: @peer_teacher_login }
            else
                format.html { render :new }
                format.json { render json: @peer_teacher_login.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # PATCH/PUT /login_user/1
    def update
        respond_to do |format|
          if @peer_teacher_login.update(peer_teacher_login_params)
            format.html { redirect_to @peer_teacher_login, notice: 'Peer Teacher User was successfully updated.' }
            format.json { render :show, status: :ok, location: @peer_teacher_login }
          else
            format.html { render :edit }
            format.json { render json: @peer_teacher_login.errors, status: :unprocessable_entity }
          end
        end
    end
    
    # DELETE /admnistrators/1 
    def destroy 
        @peer_teacher_login.destroy
        respond_to do |format|
            format.html { redirect_to teachers_url, notice: 'Peer Teacher User was successfully destroyed.' }
            format.json { head :no_content }
        end 
    end

  private
    
    def set_administrator
       @peer_teacher_login = PeerTeacherLogin.find( params[:id] ) 
    end

    def peer_teacher_login_params
        params.require(:peer_teacher_login).permit(:first_name, :last_name, user_attributes: [:id, :email, :password, :password_confirmation ])
    end
    
    def authenticate_administrator
        redirect_to( new_user_session_path) unless current_user.meta_type == "PeerTeacherLogin"
    end
    
    def new_registration
       redirect_to( login_user_path ) if user_signed_in?  
    end
end
