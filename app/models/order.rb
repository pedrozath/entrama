class Order < ActiveRecord::Base
    has_many :order_products
    has_many :products, through: :order_products

    def empty?
        products.size == 0
    end

    def price
        products.reduce(0){|sum,p|sum+=p.price}
    end

    def product_list
        list = {}
        products.map do |p|
            list[p.id.to_s] ||= []
            list[p.id.to_s] << p
        end

        list
    end
end
