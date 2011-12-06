Sample::Application.routes.draw do
  get "pages/home"
  get "pages/contact"
  get "pages/about"
  
  root :to => "pages#home" 
end