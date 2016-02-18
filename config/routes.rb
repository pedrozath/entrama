Rails.application.routes.draw do
    get "/admin" => "sessions#new"
    post "/admin" => "sessions#create"
    delete "/admin" => "sessions#destroy"

    resources :products
    
    resources :collections, path: "/" do
        resources :products
    end
end