module ApplicationHelper

  def cat_options
    Cat.all.pluck(:id, :name)
  end

end
