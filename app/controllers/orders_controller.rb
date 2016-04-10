class OrdersController < ApplicationController
    def check_out
        @order = Order.find session[:basket]
        payment = PagSeguro::PaymentRequest.new

        payment.reference = @order.id
        full_address = [request.protocol,request.host_with_port].join
        payment.notification_url = full_address+"/payment/notification"
        payment.redirect_url = full_address+"/payment/redirect"
        @order.product_list.each do |id, grouped_product|
            product = grouped_product.first
            payment.items << {
                id: id,
                description: grouped_product.first.title,
                amount: grouped_product.first.price,
                quantity: grouped_product.size,
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

    def notification
        transaction = PagSeguro::Transaction.find_by_code(params[:notificationCode])

        puts transaction

        if transaction.errors.empty?
          # Processa a notificação. A melhor maneira de se fazer isso é realizar
          # o processamento em background. Uma boa alternativa para isso é a
          # biblioteca Sidekiq.
        end
    end

    def add_product
        Order.find(session[:basket]).products << Product.find(params[:product_id])
        redirect_to "/basket"
    end

    def basket
        @order = Order.find(session[:basket])
        render action: :show
    end

    def show

    end

end