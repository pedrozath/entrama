Rails.application.routes.draw do
    get "/admin" => "sessions#new"
    post "/admin" => "sessions#create"
    delete "/admin" => "sessions#destroy"

    get "/orders/buy/:product_id" => "orders#add_product"
    get "/products/:id/edit_icon" => "products#edit_icon"

    get "/basket/remove_product/:product_id" => "orders#remove_product"
    get "/basket/add_product/:product_id" => "orders#add_product"
    get "/basket/remove_all_products/:product_id" => "orders#remove_all_products"
    get "/basket" => "orders#basket"

    get "/check_out" => "orders#check_out"
    get "/payment/notification" => "orders#notification"
    get "/payment/redirect" => "orders#redirect"
    post "/payment/redirect" => "orders#redirect"

    resources :products
    resources :images
    resources :collections, path: "/" do
        resources :products
    end
    
    resources :orders
end