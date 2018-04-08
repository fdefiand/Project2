Rails.application.routes.draw do
  resources :controllers
  resources :camps
  resources :camp_instructors
  resources :curriculums
  resources :instructors
  resources :locations
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
