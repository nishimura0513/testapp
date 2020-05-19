Rails.application.routes.draw do


    devise_for :gusers, :controllers => {
    :registrations => 'gusers/registrations',
    :sessions => 'gusers/sessions',
    omniauth_callbacks: "gusers/omniauth_callbacks"
    }

  devise_scope :guser do
    get "guser/:id", :to => "gusers/registrations#detail"
    get "g_signup", :to => "gusers/registrations#new"
    get "g_login", :to => "gusers/sessions#new"
    get "g_logout", :to => "gusers/sessions#destroy"
  end
  #guser

  get "users/new" => "users#new"
  post "users/create" => "users#create"
  post 'signup'=> "users#signup"
  get 'signup'=> "users#signup_form"
  get "signout" => "users#signout"
  get "users/:id/profile" =>"users#profile"
  get "users/:id/edit" => "users#edit"

  get "/" => "posts#top"
  get "posts/new" => "posts#new"
  get "posts/search_form" => "posts#search_form"
  post "posts/create" =>"posts#create"
  get "posts/:id" => "posts#show"
  get "posts/:id/image" => "posts#image"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  post "likes/:id/create" => "likes#create"
  post "likes/:id/destroy" => "likes#destroy"
  get "likes/:id/profile" => "likes#profile"


  resources :users
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
