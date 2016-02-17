class SessionsController < ApplicationController
    def new
        
    end
    
    def create
        session[:password] = params[:session][:password]
        if view_context.admin?
            redirect_to "/"
        else
            redirect_to :back
        end
    end

    def destroy
        session.delete :password
        redirect_to :back
    end
end
