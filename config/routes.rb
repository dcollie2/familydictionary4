Rails.application.routes.draw do
  devise_for :users

  resources :words do
    get :current, on: :member
  end

  resources :pages


  mount ActionCable.server => "/cable"

  resources :citations

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'words#current'


  get ":id" => "pages#page_by_name"
  get ":id.html" => "pages#page_by_name"
end
