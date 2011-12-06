Sample::Application.routes.draw do
  get "pages/home"
  get "pages/contact"
  get "pages/about"
  get "pages/help"
  
  root :to => "pages#home" 
end