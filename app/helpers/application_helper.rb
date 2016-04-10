module ApplicationHelper
    def admin?
        if session[:password] == ENV["PASSWORD"] then true else nil end
    end

    def total_cost_in_basket
        return session[:basket].uniq.inject 0 do |total, id|
            total + Product.find(id).price * session[:basket].count(id)
        end
    end

    def color_sample (color)
        content_tag :div, nil, class: "color-sample", style: "background-color: ##{color}"
    end

    def basket
        session[:basket] ||= Order.create(status: "aberto", session_id: session_id).id
        Order.find session[:basket]
    end

    def session_id
        session[:id] ||= SecureRandom.hex 
    end

end