RecipeOMatic::Application.routes.draw do

  namespace :admin do
    resources :recipes
    resources :foods, except: [:show]
  end

  root to: redirect('/recetas')

  resources :foods, path: 'alimentos' do
    resources :recipes, only: [:index], path: 'recetas'
  end

  resources :recipes, only: [:new, :create, :index, :show], path: 'recetas' do
    get :suggestion, on: :collection, path: 'sugerencia'
  end

  resources :lists, path: 'listas'

end
