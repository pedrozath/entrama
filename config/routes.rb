Rails.application.routes.draw do
    get "/admin" => "sessions#new"
    post "/admin" => "sessions#create"
    delete "/admin" => "sessions#destroy"

    get "/orders/buy/:product_id" => "orders#add_product"
    get "/products/:id/edit_icon" => "products#edit_icon"
    get "/basket" => "orders#basket"
    get "/check_out" => "orders#check_out"

    resources :products
    resources :images
    resources :collections, path: "/" do
        resources :products
    end
    
    resources :orders
end