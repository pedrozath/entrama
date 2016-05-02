class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    # protect_from_forgery with: :exception
    require 'securerandom'
    
    helper_method :admin?, :basket

    def authorize
        redirect_to "/" unless admin?
    end

    def admin?
        session[:password] == ENV["PASSWORD"]
    end

    def basket
        session[:basket] ||= Order.create(status: "aberto", session_id: session_id).id
        Order.find session[:basket]
    end

    def session_id
        session[:id] ||= SecureRandom.hex 
    end

    def check_session_ownership
        session[:id] == Order.find(session[:basket]).session_id
    end

end
