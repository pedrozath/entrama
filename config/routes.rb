Rails.application.routes.draw do
    get "/admin", to: "sessions#new"
    post "/admin", to: "sessions#create"
    delete "/admin", to: "sessions#destroy"

    get "/sobre", to: "pages#sobre"

    get "estoque", to: "products#stock", as: "stock"

    get "/orders/buy/:product_id", to: "orders#add_product"
    get "/products/:id/edit_icon", to: "products#edit_icon"
    get "/collections/:id/edit_art", to: "collections#edit_art"
    
    get "/camisetas", to: "products#index", defaults: { garb_type: "camisetas" }

    get "/basket/remove_product/:product_id", to: "orders#remove_product"
    get "/basket/add_product/:product_id", to: "orders#add_product"
    get "/basket/remove_all_products/:product_id", to: "orders#remove_all_products"
    get "/basket", to: "orders#show_basket", as: "basket"

    get "/check_out", to: "orders#check_out"
    get "/payment/notification", to: "orders#notification"
    post "/payment/notification", to: "orders#notification"
    get "/payment/redirect", to: "pages#compra_concluida"
    post "/payment/redirect", to: "pages#compra_concluida"

    resources :collections, path: "/coleções"
    resources :products, path: "/camisetas"
    
    resources :images
    resources :orders
    root to: "products#index"
    match '*path' => redirect('/'), via: :get
end