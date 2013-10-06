module ApplicationHelper
  def flush_the_flash
    if flash[:alert]
      content_tag :div, class: 'alert' do
        content_tag :p do
          flash[:alert]
        end
      end
    end
  end

  def title
    title = []
    title << @recipe.name if @recipe
    if controller_name == 'recipes' 
      title << t('.last_recipes') if action_name == 'index'
      title << t('.new_recipe') if action_name == 'new'
    end

    title << 'mis·recetas'
    title.compact.join(' — ')
  end
end
