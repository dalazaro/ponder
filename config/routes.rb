Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "application#splash"
  get "/about", to: "application#about"
  get "/signup", to: "users#new", as: "new_user"
  post "/users", to: "users#create"
  get "/users/:id", to: "users#show", as: "user"
  get "/users/:id/edit", to: "users#edit", as: "edit_user"
  patch "/users/:id", to: "users#update"
  delete "/users/:id", to: "users#destroy", as: "delete_user"

  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/posts", to: "posts#index", as: "posts"
  get "/posts/new", to: "posts#new", as: "new_post"
  post "/posts", to: "posts#create"
  get "/posts/:post_id", to: "posts#show", as: "post"
  get "/posts/:post_id/edit", to: "posts#edit", as: "edit_post"
  patch "/posts/:post_id", to: "posts#update"
  delete "/posts/:post_id", to: "posts#destroy"
end
