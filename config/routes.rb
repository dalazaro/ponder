Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "application#splash"

  get "/api", to: "application#api"

  get "/signup", to: "users#new", as: "new_user"
  post "/users", to: "users#create"
  get "/users/:id", to: "users#show", as: "user"
  get "/users/:id/edit", to: "users#edit", as: "edit_user"
  patch "/users/:id", to: "users#update"
  delete "/users/:id", to: "users#destroy", as: "delete_user"

  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/users/:user_id/posts", to: "posts#index", as: "posts"
  get "/users/:user_id/posts/new", to: "posts#new", as: "new_post"
  post "/users/:user_id/posts", to: "posts#create"
  get "/users/:user_id/posts/:post_id", to: "posts#show", as: "post"
  get "/users/:user_id/posts/:post_id/edit", to: "posts#edit", as: "edit_post"
  patch "/users/:user_id/posts/:post_id", to: "posts#update"
  delete "/users/:user_id/posts/:post_id", to: "posts#destroy"


end
