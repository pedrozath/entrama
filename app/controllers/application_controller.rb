class ApplicationController < ActionController::Base

    require 'securerandom'
    
    helper_method :admin?, :basket, :session_id

    def authorize
        redirect_to "/" unless admin?
    end

    def admin?
        session[:password] == ENV["PASSWORD"]
    end

    def basket
        session[:basket] ||= Order.create(status: "aberto", session_id: session_id).id
        Order.find_by_id(session[:basket]) || OpenStruct.new(products: [])
    end

    def session_id
        session[:id] ||= SecureRandom.hex 
    end

    def check_session_ownership
        session[:id] == Order.find(session[:basket]).session_id
    end

end
