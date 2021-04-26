# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :users
  resources :exams
  resources :colleges
  get '/', action: :enroll, controller: :users
end
