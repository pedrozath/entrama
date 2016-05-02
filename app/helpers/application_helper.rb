module ApplicationHelper
    def total_cost_in_basket
        return session[:basket].uniq.inject 0 do |total, id|
            total + Product.find(id).price * session[:basket].count(id)
        end
    end

    def color_sample (color)
        content_tag :div, nil, class: "color-sample", style: "background-color: ##{color}"
    end

end