RecipeOMatic::Application.routes.draw do

  namespace :admin do
    resources :recipes
    resources :foods, except: [:show]
  end

end
