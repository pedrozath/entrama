class BasketProductsController < ApplicationController
    def index
        @basket = session[:basket]
    end

    def create 
        session[:basket].push params[:id]
        redirect_to "/"
    end

    def destroy
        session[:basket].delete params[:id]
        redirect_to :back
    end

    def frete
        @frete = true
        @basket = session[:basket]
        render action: :index
    end
end
