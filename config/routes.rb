Sample::Application.routes.draw do

  resources :users
  resources :sessions, :only => [:new, :create, :destroy] 

  match "/signup", :to => "users#new"

  match "/signin",  :to => "sessions#new"
  match "/signout", :to => "sessions#destroy"
  match "/home", :to => "pages#home"
  match "/contact", :to => "pages#contact"
  match "/about", :to => "pages#about"
  match "/help", :to => "pages#help"
  
  root :to => "pages#home" 
end