class OrdersController < ApplicationController
    def create
        order = Order.new

        payment = PagSeguro::PaymentRequest.new

        payment.reference = order.id
        full_address = [request.protocol,request.host_with_port,request.fullpath].join
        payment.notification_url = full_address+"/pagamentos/notificacao"
        payment.redirect_url = full_address+"/pagamentos/finalizado"

        for id in session[:basket].uniq do
            product = Product.find(id)
            order.products << product
            payment.items << {
                id: id,
                description: product.title,
                amount: 1,
                quantity: session[:basket].count(id),
                weight: 300
            }
        end

        response = payment.register

        if response.errors.any?
            raise response.errors.join("\n")
        else
            redirect_to response.url
        end
    end

    def index

    end
end