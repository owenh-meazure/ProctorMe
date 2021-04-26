Rails.application.routes.draw do
  resources :users
  resources :exams
  resources :colleges
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
