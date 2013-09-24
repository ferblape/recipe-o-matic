RecipeOMatic::Application.routes.draw do

  namespace :admin do
    resources :recipes
  end

end
