RecipeOMatic::Application.routes.draw do

  namespace :admin do
    resources :foods, except: [:show]
  end

  root to: redirect('/recetas')

  resources :foods, path: 'alimentos' do
    resources :recipes, only: [:index], path: 'recetas'
  end

  resources :recipes, except: [:destroy], path: 'recetas' do
    get 'new_form', on: :collection
    get :suggestion, on: :collection, path: 'sugerencia'
  end

  resources :lists, path: 'listas'
end
