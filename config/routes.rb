Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "splash#index"

  get "/signup", to: "users#new"
  post "/users", to: "users#create"
  get "/users/:id", to: "users#show"
  get "/users/:id/edit", to: "users#edit"
  patch "/users/:id", to: "users#update"
  delete "/users/:id", to: "users#destroy"

  get "/login", to: "sessions#new"
  post "/sessions/:id", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/users/:user_id/posts/new", to: "posts#new"
  post "/users/:user_id/posts", to: "posts#create"
  get "/users/:user_id/posts/:post_id", to: "posts#show"
  get "/users/:user_id/posts/:post_id/edit", to: "posts#edit"
  patch "/users/:user_id/posts/:post_id", to: "posts#update"
  delete "/users/:user_id/posts/:post_id", to: "posts#destroy"

end
