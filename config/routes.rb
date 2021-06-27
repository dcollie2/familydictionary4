Rails.application.routes.draw do
  resources :words do
    get :current, on: :member
  end

  resources :citations

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'words#current'
end
