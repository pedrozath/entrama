class ApplicationController < ActionController::Base

    require 'securerandom'
    
    helper_method :admin?, :basket, :session_id
    before_filter :define_facebook_meta_tags

    def define_facebook_meta_tags
        address = [request.protocol,request.host_with_port].join
        @facebook_meta_tags = {
            app_id: 760929640709861,
            site_name: "Entrama",
            title: "Camisetas Entrama",
            description: "Produzimos camisetas com estampas geradas por algoritmos de computador.",
            image: Product.offset(rand(Product.count)).first.icon_image(:medium)
        }
    end

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
