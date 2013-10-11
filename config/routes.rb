RecipeOMatic::Application.routes.draw do

  namespace :admin do
    resources :recipes
    resources :foods, except: [:show]
  end

  root to: redirect('/recipes')

  resources :foods do
    resources :recipes, only: [:index]
  end

  resources :recipes, only: [:new, :create, :index, :show] do
    get :suggestion, on: :collection
  end

end
