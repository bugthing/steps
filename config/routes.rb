Steps::Application.routes.draw do
  root to: "home#index"
  resources :plans
  resources :nodes
end
