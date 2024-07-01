Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :blog_posts do
    resource :cover_image, only: [:destroy], module: :blog_posts
  end

  get 'contact', to: 'home#contact'
  # get "/blog_posts/new", to: "blog_posts#new", as: :new_blog_post
  # get "/blog_posts/:id/edit", to: "blog_posts#edit", as: :edit_blog_post
  # patch "/blog_posts/:id", to: "blog_posts#update"
  # delete "/blog_posts/:id", to: "blog_posts#destroy"
  # get "/blog_posts/:id", to: "blog_posts#show", as: :blog_post
  # post "/blog_posts", to: "blog_posts#create", as: :blog_posts

  # root "blog_posts#index"
  root "home#index"
end
