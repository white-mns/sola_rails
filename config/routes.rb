Rails.application.routes.draw do
  resources :status_dummies
  resources :new_skills
  resources :nuclears
  resources :parties
  resources :aps
  get "skill/history",  :to => "skills#history",  :as => "skill_history"
  resources :skills
  resources :skill_data
  resources :equips
  resources :set_classes
  get "status/graphs",  :to => "statuses#graphs",  :as => "status_graphs"
  resources :statuses
  resources :names
  resources :proper_names
  resources :uploaded_checks
  get 'script', :to => "top_page#script", :as => "top_page_script"
  get 'privacy', :to => "top_page#privacy", :as => "top_page_privacy"
  root 'top_page#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
