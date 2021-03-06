Rails.application.routes.draw do

  namespace :admin do
    resources :foods, except: [:show]
  end

  root to: redirect('/recetas')

  get '/auth/twitter/callback', to: 'sessions#authenticate'
  get '/logout', to: 'sessions#logout'

  get "/gobierto-embed(/*any)" => "gobierto#index"

  resources :foods, path: 'alimentos' do
    resources :recipes, only: [:index], path: 'recetas'
  end

  resources :recipes, except: [:destroy], path: 'recetas' do
    get 'new_form', on: :collection
    get :suggestion, on: :collection, path: 'sugerencia'
  end

  resources :lists, path: 'listas' do
    post 'recipes', on: :member
  end
end
