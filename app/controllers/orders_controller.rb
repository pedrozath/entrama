class OrdersController < ApplicationController
    before_filter :check_session_ownership, :only => [
        :add_product, 
        :remove_product,
        :remove_all_products,
        :basket
    ]
    
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
                weight: (grouped_product.size*145)+50,
            }
        end

        UserMailer.notify_sale(request.remote_ip).deliver

        response = payment.register

        if response.errors.any?
            raise response.errors.join("\n")
        else
            redirect_to response.url
        end

        session[:basket] = nil
    end

    def notification
        puts "********************************"
        puts "******** Y E S ! ! ! ***********"
        puts "********************************"

        transaction = PagSeguro::Transaction.find_by_code(params[:notificationCode])

        puts transaction

        if transaction.errors.empty?
          # Processa a notificação. A melhor maneira de se fazer isso é realizar
          # o processamento em background. Uma boa alternativa para isso é a
          # biblioteca Sidekiq.
        end

        render nothing: true
    end

    def add_product
        Order.find(session[:basket]).products << Product.find(params[:product_id])
        respond_to do |f|
            f.html { redirect_to "/basket" }
            f.json { render nothing: true }
        end
    end

    def remove_product
        Order.find(session[:basket]).order_products.where(product_id: params[:product_id]).first.destroy()
        respond_to do |f|
            f.html { redirect_to "/basket" }
            f.json { render nothing: true }
        end
    end

    def remove_all_products
        Order.find(session[:basket]).products.delete Product.find(params[:product_id])
        respond_to do |f|
            f.html { redirect_to "/basket" }
            f.json { render nothing: true }
        end
    end

    def show_basket
        @order = Order.find(session[:basket])
        render action: :show
    end

    def show

    end

end