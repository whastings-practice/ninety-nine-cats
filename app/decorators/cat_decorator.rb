class CatDecorator < Draper::Decorator
  delegate_all

  def sex_options
    object.class.const_get(:SEXES)
  end

  def color_options
    {}.tap do |color_options|
      object.class.const_get(:ALLOWED_COLORS).each do |color|
        color_options[color] = color.capitalize
      end
    end
  end

  def sex_string
    sex_options[object.sex]
  end

  def sex_checked(sex)
    if object.sex == sex
      ' checked="checked"'
    else
      ""
    end
  end

  def color_selected(color)
    if object.color == color
      ' selected="selected"'
    else
      ""
    end
  end

  def form_url
    if object.persisted?
      h.cat_url(object)
    else
      h.cats_url
    end
  end

  def submit_text
    if object.persisted?
      "Edit Cat"
    else
      "Add Cat"
    end
  end
end
