module ApplicationHelper

  def cat_options
    Cat.all.pluck(:id, :name)
  end

  def pretty_date(date)
    return unless date
    date.strftime('%b %-d, %Y')
  end

end
