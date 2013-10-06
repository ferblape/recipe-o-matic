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
end
