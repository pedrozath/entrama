Rails.application.routes.draw do
    # match "(errors)/:status", to: redirect("/"), via: :all
    get "/admin" => "sessions#new"
    post "/admin" => "sessions#create"
    delete "/admin" => "sessions#destroy"

    get "/sobre" => "pages#sobre"

    get "/orders/buy/:product_id" => "orders#add_product"
    get "/products/:id/edit_icon" => "products#edit_icon"
    get "/collections/:id/edit_art" => "collections#edit_art"

    get "/basket/remove_product/:product_id" => "orders#remove_product"
    get "/basket/add_product/:product_id" => "orders#add_product"
    get "/basket/remove_all_products/:product_id" => "orders#remove_all_products"
    get "/basket" => "orders#show_basket"

    get "/check_out" => "orders#check_out"
    get "/payment/notification" => "orders#notification"
    post "/payment/notification" => "orders#notification"
    get "/payment/redirect" => "pages#compra_concluida"
    post "/payment/redirect" => "pages#compra_concluida"

    resources :products
    resources :images
    resources :collections, path: "/" do
        resources :products
    end
    
    resources :collections
    
    resources :orders
end