Rails.application.routes.draw do
    get "/admin" => "sessions#new"
    post "/admin" => "sessions#create"
    delete "/admin" => "sessions#destroy"

    get "products/:id/edit_icon" => "products#edit_icon"
    resources :products
    resources :images
    resources :collections, path: "/" do
        resources :products
    end
end