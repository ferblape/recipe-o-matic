RecipeOMatic::Application.routes.draw do

  namespace :admin do
    resources :recipes
    resources :foods, except: [:show]
  end

  root to: 'recipes#index'

  resources :recipes, only: [:show]

end
