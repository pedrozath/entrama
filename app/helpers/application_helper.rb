module ApplicationHelper
    def admin?
        session[:password] == ENV["PASSWORD"]
    end

    def total_cost_in_basket
        return session[:basket].uniq.inject 0 do |total, id|
            total + Product.find(id).price * session[:basket].count(id)
        end
    end
end
