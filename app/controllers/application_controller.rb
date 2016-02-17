class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    # protect_from_forgery with: :exception
    before_filter :create_basket

    protected

    def create_basket
        session[:basket] ||= []
    end
end
