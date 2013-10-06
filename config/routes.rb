RecipeOMatic::Application.routes.draw do

  namespace :admin do
    resources :recipes
    resources :foods, except: [:show]
  end

  root to: redirect('/recipes')

  resources :recipes, only: [:new, :create, :index, :show]

end
