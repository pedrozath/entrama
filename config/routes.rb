Rails.application.routes.draw do
    get "/admin" => "sessions#new"
    post "/admin" => "sessions#create"
    resources :collections, path: "/"
end