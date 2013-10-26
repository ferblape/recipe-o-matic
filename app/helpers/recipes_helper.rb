module RecipesHelper
  def split_in_two_groups(group)
    size = group.size

    [group[0..size/2], group[((size/2)+1)..-1]]
  end
end
