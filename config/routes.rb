Rails.application.routes.draw do
  resources :statuses
  resources :names
  resources :proper_names
  resources :uploaded_checks
  get 'top_page/privacy'
  root 'top_page#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
